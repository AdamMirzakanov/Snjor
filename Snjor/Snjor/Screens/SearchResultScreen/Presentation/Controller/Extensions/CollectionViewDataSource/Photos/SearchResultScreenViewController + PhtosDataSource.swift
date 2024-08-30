//
//  SearchResultScreenViewController + PhtosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

extension SearchResultScreenViewController {
  
  // MARK: - Private Properties
  private var photosSnapshot: NSDiffableDataSourceSnapshot<SearchResultPhotosSection, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<SearchResultPhotosSection, Photo>()
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
    delegate: any SearchResultPhotoCellDelegate
  ) {
    photosDataSource = UICollectionViewDiffableDataSource<SearchResultPhotosSection, Photo>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      let cell = UICollectionViewCell()
      guard let strongSelf = self else { return cell }
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
    delegate: any SearchResultPhotoCellDelegate
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
    delegate: any SearchResultPhotoCellDelegate
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: SearchResultPhotoCell.reuseID,
      for: indexPath
    ) as? SearchResultPhotoCell else {
      return UICollectionViewCell()
    }
    
    guard let currentSearchTerm = self.currentSearchTerm else {
      return cell
    }
    let viewModelItem = photosViewModel.getPhotoListViewModelItem(
      at: indexPath.item,
      with: currentSearchTerm
    )
    cell.delegate = delegate
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
