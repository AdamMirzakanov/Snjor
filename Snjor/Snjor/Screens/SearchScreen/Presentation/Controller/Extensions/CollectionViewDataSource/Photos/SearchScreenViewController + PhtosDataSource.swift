//
//  SearchScreenViewController + PhtosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

extension SearchScreenViewController {
  
  private typealias DataSource = UICollectionViewDiffableDataSource<PhotosSection, Photo>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<PhotosSection, Photo>
  
  // MARK: - Private Properties
  private var photosSnapshot: Snapshot {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(photosViewModel.photos, toSection: .main)
    photosSections = snapshot.sectionIdentifiers
    return snapshot
  }
  // MARK: - Internal Methods
  func applyPhotosSnapshot() {
    guard let dataSource = photosDataSource else { return }
    dataSource.apply(
      photosSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: - Create Data Source
  func createPhotosDataSource(
    for collectionView: UICollectionView,
    delegate: any PhotoCellDelegate
  ) {
    photosDataSource = DataSource(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      let cell = UICollectionViewCell()
      guard let strongSelf = self else { return cell }
      let section = strongSelf.photosSections[indexPath.section]
      switch section {
      case .main:
        return strongSelf.configureCell(
          collectionView: collectionView,
          indexPath: indexPath,
          photo: photo,
          delegate: delegate
        )
      }
    }
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo,
    delegate: any PhotoCellDelegate
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PhotoCell.reuseID,
        for: indexPath
      ) as? PhotoCell
    else {
      return UICollectionViewCell()
    }
    
    cell.delegate = delegate
    photosViewModel.checkAndLoadMorePhotos(at: indexPath.item)
    let viewModelItem = photosViewModel.getPhotoListViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
