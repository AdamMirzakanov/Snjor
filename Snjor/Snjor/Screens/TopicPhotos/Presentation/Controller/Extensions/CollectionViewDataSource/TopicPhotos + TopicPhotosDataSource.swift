//
//  TopicPhotos + TopicPhotosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

extension TopicPhotosViewController {
  
  private typealias DataSource = UICollectionViewDiffableDataSource<TopicPhotosSection, Photo>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<TopicPhotosSection, Photo>
  
  // MARK: - Private Properties
  private var snapshot: Snapshot {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.photos)
    return snapshot
  }
  
  // MARK: - Internal Methods
  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(
      snapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: - Create Data Source
  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any TopicPhotoCellDelegate
  ) {
    dataSource = DataSource(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      guard let strongSelf = self else { return UICollectionViewCell() }
      return strongSelf.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        photo: photo,
        delegate: delegate
      )
    }
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo,
    delegate: any TopicPhotoCellDelegate
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TopicPhotoCell.reuseID,
        for: indexPath
      ) as? TopicPhotoCell
    else {
      return UICollectionViewCell()
    }
    cell.delegate = delegate
    viewModel.checkAndLoadMorePhotos(at: indexPath.item)
    let viewModelItem = viewModel.getTopicPhotoListViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}