//
//  PhotoDetailViewController.swift
//  Snjor
//
//  Created by Адам on 18.06.2024.
//

import UIKit
import Combine

final class PhotoDetailViewController: BaseViewController<PhotoDetailContainerView> {
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  var downloadService = DownloadService()
  var sessionID = UUID().uuidString
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
    mainView.delegate = self
    configUI()
    stateController()
    viewModel.viewDidLoad()
    configureDownloadSession()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.showCustomTabBar()
    }
    downloadService.invalidateSession(withID: sessionID)
  }

  deinit {
    print(#function, "деинициализирован")
  }
  
  // MARK: - Private Methods
  func configureDownloadSession() {
    downloadService.configureSession(
      delegate: self,
      id: sessionID
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
          mainView.setupPhotoInfoData(viewModel: viewModel)
        case .loading: break
        case .fail(error: let error):
          presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }

  private func configUI() {
    mainView.setupData(viewModel: viewModel)
    mainView.setupBarButtonItems(
      navigationItem: navigationItem, 
      navigationController: navigationController
    )
  }
}

extension PhotoDetailViewController: PhotoDetailContainerViewDelegate {
  func didTapDownloadButton() {
    showSpinner(on: mainView.spinnerBlurEffect)
    downloadService.startDownload(
      viewModel.photo!,
      sessionID: sessionID
    )
  }
}
