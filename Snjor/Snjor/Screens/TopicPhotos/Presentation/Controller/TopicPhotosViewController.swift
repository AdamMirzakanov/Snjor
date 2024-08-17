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
  
  // MARK: - Internal Properties
  
  // MARK: - Delegate
  private(set) weak var delegate: (any TopicPhotosViewControllerDelegate)?
  
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var viewModel: any TopicPhotosViewModelProtocol
  
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
    viewModel.createDataSource(
      for: rootView.topicPhotosCollectionView
    )
  }
  
  private func resetPage() {
    PrepareParameters.page = .zero
  }
  
  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          self.viewModel.applySnapshot()
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
}
