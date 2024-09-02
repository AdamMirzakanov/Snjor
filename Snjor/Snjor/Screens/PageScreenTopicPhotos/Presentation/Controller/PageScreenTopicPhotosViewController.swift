//
//  PageScreenTopicPhotosViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

protocol PageScreenTopicPhotosViewControllerDelegate: AnyObject {
  func didSelect(_ photo: Photo)
}

final class PageScreenTopicPhotosViewController: BaseViewController<PageScreenTopicPhotosRootView> {
  
  // MARK: - Internal Properties
  var topicID: String?
  var pageIndex: Int?
  var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?
  
  // MARK: - Delegate
  private(set) weak var delegate: (any PageScreenTopicPhotosViewControllerDelegate)?
  
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var viewModel: any ItemsViewModelProtocol <Photo>
  
  // MARK: - Initializers
  init(
    viewModel: any ItemsViewModelProtocol <Photo>,
    delegate: any PageScreenTopicPhotosViewControllerDelegate,
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
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configCollectionView()
    setupDataSource()
    resetPage()
    viewModel.viewDidLoad()
    stateController()
  }
  
  // MARK: - Private Methods
  private func setupDataSource() {
    createDataSource(
      for: rootView.pageScreenTopicPhotosCollectionView
    )
  }
  
  private func resetPage() {
    PrepareParameters.photosPage = .zero
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
    rootView.pageScreenTopicPhotosCollectionView.delegate = self
  }
}
