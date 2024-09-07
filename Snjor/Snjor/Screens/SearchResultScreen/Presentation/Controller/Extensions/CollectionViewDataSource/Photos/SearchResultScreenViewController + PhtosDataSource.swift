//
//  SearchResultViewController + PhtosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

extension SearchResultViewController {
  
  // MARK: Private Properties
  private var photosSnapshot: NSDiffableDataSourceSnapshot<SearchResultPhotosSection, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<SearchResultPhotosSection, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(photosViewModel.items, toSection: .main)
    photosSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: Internal Methods
  func applyPhotosSnapshot() {
    guard let dataSource = photosDataSource else { return }
    dataSource.apply(
      photosSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createPhotosDataSource(
    for collectionView: UICollectionView,
    delegate: any SearchScreenPhotoCellDelegate
  ) {
    photosDataSource = UICollectionViewDiffableDataSource<SearchResultPhotosSection, Photo>(
      collectionView: collectionView
    ) { [weak self, weak delegate] collectionView, indexPath, photo in
      let cell = UICollectionViewCell()
      guard
        let self = self,
        let delegate = delegate else {
        return cell
      }
      return self.configureCell(
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
    delegate: any SearchScreenPhotoCellDelegate
  ) -> UICollectionViewCell {
    let section = photosSections[indexPath.section]
    switch section {
    case .main:
      return configurePhotoCell(
        collectionView: collectionView,
        indexPath: indexPath,
        photo: photo,
        delegate: delegate
      )
    }
  }
  
  private func configurePhotoCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo,
    delegate: any SearchScreenPhotoCellDelegate
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: SearchScreenPhotoCell.reuseID,
      for: indexPath
    ) as? SearchScreenPhotoCell else {
      return UICollectionViewCell()
    }
    
    guard let currentSearchTerm = self.currentSearchTerm else {
      return cell
    }
    let viewModelItem = photosViewModel.getSearchItemsViewModelItem(
      at: indexPath.item,
      with: currentSearchTerm
    )
    cell.delegate = delegate
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
