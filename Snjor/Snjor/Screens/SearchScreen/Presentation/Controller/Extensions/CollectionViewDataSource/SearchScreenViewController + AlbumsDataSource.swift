//
//  SearchScreenViewController + AlbumsDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

extension SearchScreenViewController {
  private var snapshot: NSDiffableDataSourceSnapshot<AlbumsSection, Album> {
    var snapshot = NSDiffableDataSourceSnapshot<AlbumsSection, Album>()
    snapshot.appendSections([.main])
    snapshot.appendItems(albumsViewModel.albums, toSection: .main)
    albumsSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  func createAlbumsDataSource(for collectionView: UICollectionView) {
    albumsDataSource = UICollectionViewDiffableDataSource<AlbumsSection, Album>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, album in
      
      let defaultCell = UICollectionViewCell()
      
      guard let strongSelf = self else { return defaultCell }
      
      let section = strongSelf.albumsSections[indexPath.section]
      switch section {
      case .main:
        return strongSelf.configureCell(
          collectionView: collectionView,
          indexPath: indexPath,
          album: album
        )
      }
    }
  }
  
  func applySnapshot() {
    guard let dataSource = albumsDataSource else { return }
    dataSource.apply(
      snapshot,
      animatingDifferences: true
    )
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    album: Album
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: AlbumCell.reuseID,
        for: indexPath
      ) as? AlbumCell
    else {
      return UICollectionViewCell()
    }
    
    albumsViewModel.checkAndLoadMoreAlbums(at: indexPath.item)
    let viewModelItem = albumsViewModel.getAlbumsViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
}

enum AlbumsSection: Hashable {
  case main
}
