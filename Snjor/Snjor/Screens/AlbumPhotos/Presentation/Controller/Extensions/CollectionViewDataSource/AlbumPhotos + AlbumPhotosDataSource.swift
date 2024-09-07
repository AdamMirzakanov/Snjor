//
//  AlbumPhotos + AlbumPhotosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

extension AlbumPhotosViewController {

  // MARK: Private Properties
  private var albumPhotosSnapshot: AlbumPhotosSnapshot {
    var snapshot = AlbumPhotosSnapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.items)
    return snapshot
  }
  
  // MARK: Internal Methods
  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(
      albumPhotosSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any AlbumPhotoCellDelegate
  ) {
    dataSource = AlbumPhotosDataSource(
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
    delegate: any AlbumPhotoCellDelegate
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: AlbumPhotoCell.reuseID,
        for: indexPath
      ) as? AlbumPhotoCell
    else {
      return UICollectionViewCell()
    }
    cell.delegate = delegate
    let viewModelItem = viewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
