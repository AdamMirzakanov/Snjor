//
//  SearchResultViewController + AlbumsDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

import UIKit

extension SearchResultViewController {
  
  // MARK: Private Properties
  private var albumsSnapshot: SearchResultAlbumsSnapshot {
    var snapshot = SearchResultAlbumsSnapshot()
    snapshot.appendSections([.albums])
    snapshot.appendItems(albumsViewModel.items, toSection: .albums)
    albumsSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: Internal Methods
  func applyAlbumsSnapshot() {
    guard let dataSource = albumsDataSource else { return }
    dataSource.apply(
      albumsSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createCollectionsDataSource(
    for collectionView: UICollectionView,
    delegate: any AlbumCellDelegate
  ) {
    albumsDataSource = SearchResultAlbumsDataSource(
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
  }
  
  // MARK: Configure Cells
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    item: Album,
    delegate: any AlbumCellDelegate
  ) -> UICollectionViewCell {
    let section = albumsSections[indexPath.section]
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
