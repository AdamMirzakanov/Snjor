//
//  PageScreenPhotos + PageScreenPhotosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import UIKit

extension PageScreenPhotosViewController {
  
  private typealias DataSource = UICollectionViewDiffableDataSource<PageScreenPhotosSection, Photo>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<PageScreenPhotosSection, Photo>
  
  private var snapshot: NSDiffableDataSourceSnapshot<PageScreenPhotosSection, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<PageScreenPhotosSection, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.items)
    return snapshot
  }
  
  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(
      snapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createDataSource(
    for collectionView: UICollectionView
  ) {
    dataSource = UICollectionViewDiffableDataSource<PageScreenPhotosSection, Photo>(
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
