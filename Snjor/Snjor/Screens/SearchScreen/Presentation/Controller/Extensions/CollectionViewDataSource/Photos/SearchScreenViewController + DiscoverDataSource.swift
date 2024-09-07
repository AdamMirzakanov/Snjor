//
//  SearchScreenViewController + DiscoverDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

extension SearchScreenViewController {
  // MARK: Private Properties
  private var discoverSnapshot: DiscoverSnapshot {
    var snapshot = DiscoverSnapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(photosViewModel.items, toSection: .main)
    discoverSections = snapshot.sectionIdentifiers
    return snapshot
  }

  // MARK: Internal Methods
  func applyPhotosSnapshot() {
    guard let dataSource = discoverDataSource else { return }
    dataSource.apply(
      discoverSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createPhotosDataSource(
    for collectionView: UICollectionView,
    delegate: any SearchScreenPhotoCellDelegate
  ) {
    discoverDataSource = DiscoverDataSource(
      collectionView: collectionView
    ) { [weak self, weak delegate] collectionView, indexPath, photo in
      let cell = UICollectionViewCell()
      guard
        let self = self,
        let delegate = delegate
      else {
        return cell
      }
      let section = self.discoverSections[indexPath.section]
      switch section {
      case .main:
        return self.configureCell(
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
    delegate: any SearchScreenPhotoCellDelegate
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: SearchScreenPhotoCell.reuseID,
        for: indexPath
      ) as? SearchScreenPhotoCell
    else {
      return UICollectionViewCell()
    }
    
    cell.delegate = delegate
    let viewModelItem = photosViewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
