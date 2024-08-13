//
//  SearchScreenViewController + PhtosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

extension SearchScreenViewController {
  private var photosSnapshot: NSDiffableDataSourceSnapshot<PhotoListSection, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(photosViewModel.photos, toSection: .main)
    sections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any PhotoCellDelegate
  ) {
    photosDataSource = UICollectionViewDiffableDataSource<PhotoListSection, Photo>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      let defaultCell = UICollectionViewCell()
      guard let strongSelf = self else { return defaultCell }
      let section = strongSelf.sections[indexPath.section]
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
  
  func configureCell(
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
  
  func applyPhotosSnapshot() {
    guard let dataSource = photosDataSource else { return }
    dataSource.apply(
      photosSnapshot,
      animatingDifferences: true
    )
  }
}

enum PhotoListSection: Hashable {
  case main
}
