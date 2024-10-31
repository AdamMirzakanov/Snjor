//
//  TopicPhotosViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit
import Combine

final class TopicPhotosViewController: MainViewController<TopicPhotosRootView> {
  // MARK: internal Properties
  var topicPhotosDataSource: TopicPhotosDataSource?
  
  // MARK: Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) weak var delegate: (any TopicPhotosViewControllerDelegate)?
  private(set) var downloadService = DownloadService()
  private(set) var viewModel: any ContentManagingProtocol<Photo>
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  // MARK: Override Properties
  override var shouldShowTabBarOnScroll: Bool {
    return false
  }
  
  // MARK: Initializers
  init(
    viewModel: any ContentManagingProtocol<Photo>,
    delegate: any TopicPhotosViewControllerDelegate,
    layout: UICollectionViewLayout
  ) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configCollectionView()
    setupDataSource()
    viewModel.viewDidLoad()
    stateController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationItems()
    hideCustomTabBar()
    configureDownloadSession()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    resetState()
  }
  
  // MARK: Private Methods
  private func resetState() {
    if self.isMovingFromParent {
      PrepareParameters.photosPage = .zero
      topicPhotosDataSource = nil
      cancellable.removeAll()
    }
    downloadService.invalidateSession(withID: Self.sessionID)
  }
  
  private func setupDataSource() {
    createDataSource(
      for: rootView.topicPhotosCollectionView, 
      delegate: self
    )
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
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          self.applySnapshot()
        case .loading: break
        case .fail(error: let error):
          showError(error: error)
        }
      }
      .store(in: &cancellable)
  }
  
  private func showError(error: String) {
    guard let navigationController = navigationController else { return }
    navigationItem.rightBarButtonItem?.isHidden = true
    navigationItem.leftBarButtonItem?.isHidden = true
    navigationItem.title = .empty
    rootView.topicPhotosCollectionView.isHidden = true
    showError(error: error, navigationController: navigationController)
  }
  
  private func configCollectionView() {
    rootView.topicPhotosCollectionView.delegate = self
  }
  
  private func setupNavigationItems() {
    rootView.setupBarButtonItems(
      navigationItem: navigationItem,
      navigationController: navigationController
    )
  }
}
