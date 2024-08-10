//
//  AlbumListViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit
import Combine

class AlbumListViewController: UICollectionViewController {
  
  // MARK: - Delegate
  
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var viewModel: any AlbumListViewModelProtocol
  
  // MARK: - Initializers
  init(
    viewModel: any AlbumListViewModelProtocol,
    layout: UICollectionViewLayout
  ) {
    self.viewModel = viewModel
    super.init(collectionViewLayout: layout)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
    stateController()
    setupDataSource()
  }
  
  // MARK: - Private Methods
  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          viewModel.applySnapshot()
        case .loading: break
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }
  
  private func setupDataSource() {
    viewModel.createDataSource(
      for: collectionView
    )
  }
}
