//
//  AlbumPhotos + AlbumPhotosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

extension AlbumPhotosViewController {

  private typealias DataSource = UICollectionViewDiffableDataSource<AlbumPhotosSection, Photo>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<AlbumPhotosSection, Photo>
  
  private var snapshot: Snapshot {
    var snapshot = Snapshot()
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
    for collectionView: UICollectionView,
    delegate: any AlbumPhotoCellDelegate
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
