//
//  PhotoDetailViewController.swift
//  Snjor
//
//  Created by Адам on 18.06.2024.
//

import UIKit
import Combine

final class PhotoDetailViewController: BaseViewController<PhotoDetailRootView> {

  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var downloadService = DownloadService()
  private(set) var viewModel: any PhotoDetailViewModelProtocol
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!

  // MARK: - Initializers
  init(viewModel: any PhotoDetailViewModelProtocol
  ) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    rootView.delegate = self
    setupUI()
    stateController()
    viewModel.viewDidLoad()
    configureDownloadSession()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    hideCustomTabBar()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    showCustomTabBar()
    if self.isMovingFromParent || self.isBeingDismissed {
      downloadService.invalidateSession(withID: Self.sessionID)
    }
  }

  deinit {
    print(#function, Self.self, "деинициализирован")
  }
  
  // MARK: - Private Methods
  private func hideCustomTabBar() {
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }

  private func showCustomTabBar() {
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.showCustomTabBar()
    }
  }

  private func configureDownloadSession() {
    downloadService.configureSession(
      delegate: self,
      id: Self.sessionID
    )
  }

  private func stateController() {
    viewModel
      .state
      .receive(on: RunLoop.current)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          rootView.setupPhotoInfoData(viewModel: viewModel)
        case .loading: break
        case .fail(error: let error):
          presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }

  private func setupUI() {
    rootView.setupData(viewModel: viewModel)
    rootView.setupBarButtonItems(
      navigationItem: navigationItem,
      navigationController: navigationController
    )
  }
}
