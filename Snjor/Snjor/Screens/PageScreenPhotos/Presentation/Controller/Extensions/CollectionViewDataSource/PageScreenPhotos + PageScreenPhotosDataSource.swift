//
//  PageScreenPhotos + PageScreenPhotosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import UIKit

extension PageScreenPhotosViewController {
  
  // MARK: Private Properties
  private var pageScreenPhotosSnapshot: PageScreenPhotosSnapshot {
    var snapshot = PageScreenPhotosSnapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.items)
    return snapshot
  }
  
  // MARK: Internal Methods
  func applySnapshot() {
    guard let dataSource = pageScreenPhotosDataSource else { return }
    dataSource.apply(
      pageScreenPhotosSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createDataSource(
    for collectionView: UICollectionView
  ) {
    pageScreenPhotosDataSource = PageScreenPhotosDataSource(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      guard let strongSelf = self else { return UICollectionViewCell() }
      return strongSelf.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        photo: photo
      )
    }
  }
  
  // MARK: Configure Cells
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PageScreenPhotoCell.reuseID,
        for: indexPath
      ) as? PageScreenPhotoCell
    else {
      return UICollectionViewCell()
    }
    
    let viewModelItem = viewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
