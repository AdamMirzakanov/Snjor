//
//  SearchResultViewController + AlbumsDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

import UIKit

extension SearchResultViewController {
  
  // MARK: Private Properties
  private var collectionsSnapshot: SearchResultAlbumsSnapshot {
    var snapshot = SearchResultAlbumsSnapshot()
    snapshot.appendSections([.albums])
    snapshot.appendItems(albumsViewModel.items, toSection: .albums)
    collectionsSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: Internal Methods
  func applyCollectionsSnapshot() {
    guard let dataSource = collectionsDataSource else { return }
    dataSource.apply(
      collectionsSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createCollectionsDataSource(
    for collectionView: UICollectionView,
    delegate: any AlbumCellDelegate
  ) {
    collectionsDataSource = SearchResultAlbumsDataSource(
      collectionView: collectionView
    ) { [weak self, weak delegate] collectionView, indexPath, item in
      guard
        let self = self,
        let delegate = delegate
      else {
        return UICollectionViewCell()
      }
      return self.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        item: item,
        delegate: delegate
      )
    }
    
//    collectionsDataSource?.supplementaryViewProvider = {
//      [weak self] collectionView, kind, indexPath in
//      guard let strongSelf = self else {
//        return UICollectionReusableView()
//      }
//      return strongSelf.configureSupplementaryView(
//        collectionView: collectionView,
//        kind: kind,
//        indexPath: indexPath
//      )
//    }
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    item: Album,
    delegate: any AlbumCellDelegate
  ) -> UICollectionViewCell {
    let section = collectionsSections[indexPath.section]
    switch section {
    case .albums:
      return configureAlbumCell(
        collectionView: collectionView,
        indexPath: indexPath,
        album: item,
        delegate: delegate
      )
    }
  }
  
//  private func configureSupplementaryView(
//    collectionView: UICollectionView,
//    kind: String,
//    indexPath: IndexPath
//  ) -> UICollectionReusableView {
//    switch kind {
//    case SupplementaryViewKind.header:
//      return configureHeaderView(
//        collectionView: collectionView,
//        indexPath: indexPath
//      )
//    default:
//      return UICollectionReusableView()
//    }
//  }
//  
//  private func configureHeaderView(
//    collectionView: UICollectionView,
//    indexPath: IndexPath
//  ) -> UICollectionReusableView {
//    let section = collectionsSections[indexPath.section]
//    let defoultHeaderView = collectionView.dequeueReusableSupplementaryView(
//      ofKind: SupplementaryViewKind.header,
//      withReuseIdentifier: SectionHeaderView.reuseID,
//      for: indexPath
//    )
//    guard let headerView = defoultHeaderView as? SectionHeaderView else {
//      return defoultHeaderView
//    }
//    switch section {
//    case .albums:
//      return headerView
//    }
//  }
  
  // MARK: Configure Cells
  private func configureAlbumCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    album: Album,
    delegate: any AlbumCellDelegate
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: AlbumCell.reuseID,
        for: indexPath
      ) as? AlbumCell
    else {
      return UICollectionViewCell()
    }
    
    guard let currentSearchTerm = self.currentSearchTerm else {
      return cell
    }
    cell.delegate = delegate
    let viewModelItem = albumsViewModel.getSearchItemsViewModelItem(
      at: indexPath.item,
      with: currentSearchTerm
    )
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
