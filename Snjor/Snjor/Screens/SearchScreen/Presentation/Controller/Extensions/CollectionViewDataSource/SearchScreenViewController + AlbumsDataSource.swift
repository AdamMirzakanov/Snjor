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
    snapshot.appendSections([.topics("ca"), .albums("al")])
    snapshot.appendItems(albumsViewModel.albums, toSection: .albums("Al"))
//    snapshot.appendItems(albumsViewModel.albums, toSection: .albums("Al"))
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
      case .albums:
        return strongSelf.configureCell(
          collectionView: collectionView,
          indexPath: indexPath,
          album: album
        )
      case .topics:
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
  case topics(String)
  case albums(String)
}


//extension SearchScreenViewController {
//  // MARK: - Create Album Layout
//  func createAlbumLayout() -> UICollectionViewLayout {
//    let layout = UICollectionViewCompositionalLayout { (
//      sectionIndex, layoutEnvironment
//    ) -> NSCollectionLayoutSection? in
//      let item = self.makeItem()
//      let verticalGroup = self.makeVerticalGroup(item: item)
//      let section = self.makeSection(group: verticalGroup)
//      return section
//    }
//    return layout
//  }
//  
//  private func makeItem() -> NSCollectionLayoutItem {
//    let itemSize = NSCollectionLayoutSize(
//      widthDimension: .fractionalWidth(1),
//      heightDimension: .fractionalHeight(1)
//    )
//    let item = NSCollectionLayoutItem(layoutSize: itemSize)
//    item.contentInsets = NSDirectionalEdgeInsets(
//      top: 20,
//      leading: 4.0,
//      bottom: 8.0,
//      trailing: 4.0
//    )
//    return item
//  }
//  
//  private func makeVerticalGroup(
//    item: NSCollectionLayoutItem
//  ) -> NSCollectionLayoutGroup {
//    let groupSize = NSCollectionLayoutSize(
//      widthDimension: .fractionalWidth(1),
//      heightDimension: .fractionalWidth(0.6)
//    )
//    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
//      layoutSize: groupSize,
//      subitem: item,
//      count: 2
//    )
//    let verticalGroup = NSCollectionLayoutGroup.vertical(
//      layoutSize: groupSize,
//      subitems: [horizontalGroup, horizontalGroup]
//    )
//    
//    return verticalGroup
//  }
//  
//  private func makeSection(group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
//    let section = NSCollectionLayoutSection(group: group)
//    section.contentInsets = NSDirectionalEdgeInsets(
//      top: 0,
//      leading: 16.0,
//      bottom: 0,
//      trailing: 16.0
//    )
//    return section
//  }
//}
