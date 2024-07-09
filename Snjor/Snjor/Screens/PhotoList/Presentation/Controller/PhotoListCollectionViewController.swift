//
//  PhotoListCollectionViewController.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol PhotoListViewControllerDelegate: AnyObject {
  func didSelect(id: Photo)
}

class PhotoListCollectionViewController: UICollectionViewController {
  // MARK: - Private Properties
  private(set) var viewModel: any PhotoListViewModelProtocol
  private(set) weak var delegate: (any PhotoListViewControllerDelegate)?

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
    navigationItem.title = .snjor

    viewModel.createDataSource(for: collectionView)
    viewModel.viewDidLoad()
    viewModel.onPhotosChange = { [weak self] photos in
      self?.updateCollectionView(with: photos)
    }
  }

  private func updateCollectionView(with photos: [Photo]) {
    viewModel.applySnapshot()
  }
}
