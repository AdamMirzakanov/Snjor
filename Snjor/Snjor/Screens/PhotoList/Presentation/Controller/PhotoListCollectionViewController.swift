//
//  PhotoListCollectionViewController.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit
import Combine

protocol PhotoListViewControllerDelegate: AnyObject {
  func didSelect()
}

class PhotoListCollectionViewController: UICollectionViewController {
  // MARK: - Private Properties
  private(set) var viewModel: any PhotoListViewModelProtocol
  private weak var delegate: (any PhotoListViewControllerDelegate)?
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
    createDataSource()
    viewModel.viewDidLoad()
    stateController()
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
        case .loading:
          break
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }

  private func createDataSource() {
    viewModel.dataSource = UICollectionViewDiffableDataSource
    <Section, Photo>(collectionView: collectionView) { collectionView, indexPath, _  in
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PhotoCell.reuseID,
        for: indexPath
      )
      guard let waterfallCell = cell as? PhotoCell else { return cell }
      let photo = self.viewModel.loadPhoto(at: indexPath)
      waterfallCell.configure(with: photo)
      return cell
    }
  }
}
