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
    snapshot.appendItems(viewModel.items, toSection: .main)
    albumPhotosSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: Internal Methods
  func applySnapshot() {
    guard let dataSource = albumPhotosDataSource else { return }
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
    albumPhotosDataSource = AlbumPhotosDataSource(
      collectionView: collectionView
    ) { [weak self, weak delegate] collectionView, indexPath, photo in
      guard
        let self = self,
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
    
    // Заголовок коллекции
    albumPhotosDataSource?.supplementaryViewProvider = { (
      collectionView,
      kind,
      indexPath
    ) -> UICollectionReusableView? in
      
      guard kind == UICollectionView.elementKindSectionHeader else {
        return nil
      }
      
      let section = self.albumPhotosSections[indexPath.section]
      let sectionImage: UIImage
      switch section {
      case .main:
        sectionImage = SFSymbol.photoCap!
      }
      
      let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: AlbumPhotosSectionHeaderView.reuseID,
        for: indexPath
      ) as! AlbumPhotosSectionHeaderView
      
      headerView.setImage(sectionImage)
      return headerView
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
