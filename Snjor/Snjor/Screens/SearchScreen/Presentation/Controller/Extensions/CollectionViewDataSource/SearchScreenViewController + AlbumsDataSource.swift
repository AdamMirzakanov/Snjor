//
//  SearchScreenViewController + AlbumsDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

extension SearchScreenViewController {
  
  // MARK: - Internal Properties
  var collectionsSnapshot: NSDiffableDataSourceSnapshot<CollectionsSection, Item> {
    var snapshot = NSDiffableDataSourceSnapshot<CollectionsSection, Item>()
    let topicSection = CollectionsSection.topics
    let albumSection = CollectionsSection.albums("Albums")
    snapshot.appendSections([topicSection, albumSection])
    snapshot.appendItems(Item.topics, toSection: topicSection)
    snapshot.appendItems(Item.albums, toSection: albumSection)
    collectionsSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: - Internal Methods
  func applyCollectionsSnapshot() {
    guard let dataSource = collectionsDataSource else { return }
    dataSource.apply(
      collectionsSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: - Create Data Source
  func createCollectionsDataSource(for collectionView: UICollectionView) {
    collectionsDataSource = UICollectionViewDiffableDataSource<CollectionsSection, Item>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, item in
      let defaultCell = UICollectionViewCell()
      guard let strongSelf = self else { return defaultCell }
      let section = strongSelf.collectionsSections[indexPath.section]
      switch section {
      case .topics:
        if let topic = item.topic {
          return strongSelf.configureTopicCell(
            collectionView: collectionView,
            indexPath: indexPath,
            topic: topic
          )
        } else {
          return defaultCell
        }
      case .albums:
        if let album = item.album {
          return strongSelf.configureAlbumCell(
            collectionView: collectionView,
            indexPath: indexPath,
            album: album
          )
        } else {
          return defaultCell
        }
      }
    }
    
    collectionsDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
      switch kind {
      case SupplementaryViewKind.header:
        let section = self.collectionsSections[indexPath.section]
        let sectionName: String
        let defoultHeaderView = collectionView.dequeueReusableSupplementaryView(
          ofKind: SupplementaryViewKind.header,
          withReuseIdentifier: SectionHeaderView.reuseID,
          for: indexPath
        )
        guard let headerView = defoultHeaderView as? SectionHeaderView else {
          return defoultHeaderView
        }
        switch section {
        case .topics:
          return headerView
        case .albums(let name):
          sectionName = name
          headerView.setTitle(sectionName)
          return headerView
        }
        
      case SupplementaryViewKind.line:
        let lineView = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: LineView.reuseID,
          for: indexPath
        )
        guard let lineView = lineView as? LineView else {
          return lineView
        }
        return lineView
      default:
        return UICollectionReusableView()
      }
    }
  }
  
  // MARK: - Configure Cells
  private func configureAlbumCell(
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
  
  private func configureTopicCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    topic: Topic
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TopicCell.reuseID,
        for: indexPath
      ) as? TopicCell
    else {
      return UICollectionViewCell()
    }
    let viewModelItem = topicsViewModel.getTopicsPageViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}

// MARK: - Sections
enum CollectionsSection: Hashable {
  case topics
  case albums(String)
}
