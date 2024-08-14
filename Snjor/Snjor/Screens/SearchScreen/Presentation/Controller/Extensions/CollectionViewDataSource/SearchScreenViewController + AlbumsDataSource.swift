//
//  SearchScreenViewController + AlbumsDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

// Extension для SearchScreenViewController
extension SearchScreenViewController {
  
  // Создание snapshot для коллекции
  var collectionsSnapshot: NSDiffableDataSourceSnapshot<CollectionsSection, Item> {
    var snapshot = NSDiffableDataSourceSnapshot<CollectionsSection, Item>()
    snapshot.appendSections([.albums])
    snapshot.appendItems(Item.albums, toSection: .albums)
    albumsSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // Создание DataSource для коллекции
  func createAlbumsDataSource(for collectionView: UICollectionView) {
    collectionsDataSource = UICollectionViewDiffableDataSource<CollectionsSection, Item>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, item in // Изменено с album на item
      let defaultCell = UICollectionViewCell()
      guard let strongSelf = self else { return defaultCell }
      let section = strongSelf.albumsSections[indexPath.section]
      switch section {
      case .albums:
        if let album = item.album { // Проверка и извлечение альбома из item
          return strongSelf.configureCell(
            collectionView: collectionView,
            indexPath: indexPath,
            album: album
          )
        } else {
          print(#function)
          return defaultCell
        }
      }
    }
  }
  
  // Применение snapshot
  func applyAlbumsSnapshot() {
    guard let dataSource = collectionsDataSource else { return }
    dataSource.apply(
      collectionsSnapshot,
      animatingDifferences: true
    )
  }
  
  // Конфигурация ячейки
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
    
    // Проверка и загрузка дополнительных альбомов, если необходимо
    albumsViewModel.checkAndLoadMoreAlbums(at: indexPath.item)
    // Получение ViewModelItem для текущего альбома
    let viewModelItem = albumsViewModel.getAlbumsViewModelItem(at: indexPath.item)
    // Конфигурация ячейки с использованием ViewModelItem
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
}

// Определение секций для коллекции
enum CollectionsSection: Hashable {
  case albums
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
