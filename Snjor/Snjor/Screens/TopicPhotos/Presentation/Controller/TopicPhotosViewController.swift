//
//  TopicPhotosViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit
import Combine

protocol TopicPhotosViewControllerDelegate: AnyObject {
  func didSelect(_ photo: Photo)
}

final class TopicPhotosViewController: BaseViewController<TopicPhotosRootView> {
  
  // MARK: - Delegate
  private(set) weak var delegate: (any TopicPhotosViewControllerDelegate)?
  
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  var dataSource: UICollectionViewDiffableDataSource<TopicPhotosSection, Photo>?
  private(set) var downloadService = DownloadService()
  private(set) var viewModel: any TopicPhotosViewModelProtocol
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  // MARK: - Initializers
  init(
    viewModel: any TopicPhotosViewModelProtocol,
    delegate: any TopicPhotosViewControllerDelegate,
    layout: UICollectionViewLayout
  ) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    cancellable.forEach { $0.cancel() }
    print(#function, Self.self, "деинициализирован")
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configCollectionView()
    setupDataSource()
    configureDownloadSession()
    resetPage()
    viewModel.viewDidLoad()
    stateController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupUI()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if self.isMovingFromParent || self.isBeingDismissed {
      downloadService.invalidateSession(withID: Self.sessionID)
      dataSource = nil
    }
  }
  
  // MARK: - Private Methods
  private func setupDataSource() {
    createDataSource(
      for: rootView.topicPhotosCollectionView, 
      delegate: self
    )
  }
  
  private func resetPage() {
    PrepareParameters.page = .zero
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
          presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }
  
  private func configCollectionView() {
    rootView.topicPhotosCollectionView.delegate = self
  }
  
  private func setupUI() {
    rootView.setupBarButtonItems(
      navigationItem: navigationItem,
      navigationController: navigationController
    )
  }
}
