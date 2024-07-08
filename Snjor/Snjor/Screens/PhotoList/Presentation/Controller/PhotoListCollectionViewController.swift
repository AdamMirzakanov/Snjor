//
//  PhotoListCollectionViewController.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit
import Combine

protocol PhotoListViewControllerDelegate: AnyObject {
  func didSelect(id: Photo)
}

class PhotoListCollectionViewController: UICollectionViewController {
  // MARK: - Private Properties
  private(set) var viewModel: any PhotoListViewModelProtocol
  private(set) weak var delegate: (any PhotoListViewControllerDelegate)?
  private var cancellable = Set<AnyCancellable>()

  // MARK: - Initializers
  init(
    viewModel: any PhotoListViewModelProtocol,
    delegate: any PhotoListViewControllerDelegate,
    layout: UICollectionViewLayout
  ) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(collectionViewLayout: layout)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
//    stateController()
    viewModel.createDataSource(for: collectionView)
    viewModel.viewDidLoad()
    //    viewModel.setupRefreshControl(for: collectionView)
    viewModel.onPhotosChange = { [weak self] photos in
                self?.updateCollectionView(with: photos)
            }
    navigationItem.title = .snjor
  }

  private func updateCollectionView(with photos: [Photo]) {
          viewModel.applySnapshot()
//          print("CollectionView updated with photos: \(photos)")
      }

  // MARK: - Private Methods
//  private func stateController() {
//    viewModel
//      .state
//      .receive(on: DispatchQueue.main)
//      .sink { [weak self] state in
//        guard let self = self else { return }
//        switch state {
//        case .success:
//          viewModel.applySnapshot()
//          // viewModel.refreshControl.endRefreshing()
//        case .loading:
//          break
//        case .fail(error: let error):
//          self.presentAlert(message: error, title: AppLocalized.error)
//        }
//      }
//      .store(in: &cancellable)
//  }
}
