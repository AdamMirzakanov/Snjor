//
//  TopicPhotos + TopicPhotosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

extension TopicPhotosViewController {
  
  // MARK: Private Properties
  private var topicPhotosSnapshot: TopicPhotosSnapshot {
    var snapshot = TopicPhotosSnapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.items)
    return snapshot
  }
  
  // MARK: Internal Methods
  func applySnapshot() {
    guard let dataSource = topicPhotosDataSource else { return }
    dataSource.apply(
      topicPhotosSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any TopicPhotoCellDelegate
  ) {
    topicPhotosDataSource = TopicPhotosDataSource(
      collectionView: collectionView
    ) { [weak self, weak delegate] collectionView, indexPath, photo in
      guard let self = self,
            let delegate = delegate
      else {
        return UICollectionViewCell()
      }
      return self.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        photo: photo,
        delegate: delegate
      )
    }
  }
  
  // MARK: Configure Cells
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
    let viewModelItem = viewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
