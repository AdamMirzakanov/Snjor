//
//  SearchScreenViewController + AlbumsDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

extension SearchScreenViewController {
  
  private typealias DataSource = UICollectionViewDiffableDataSource<CollectionsSection, CollectionsItem>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionsSection, CollectionsItem>
  
  // MARK: - Private Properties
  private var collectionsSnapshot: Snapshot {
    var snapshot = Snapshot()
    let topicSection = CollectionsSection.topics
    let albumSection = CollectionsSection.albums("Albums")
    snapshot.appendSections([topicSection, albumSection])
    snapshot.appendItems(CollectionsItem.topics, toSection: topicSection)
    snapshot.appendItems(CollectionsItem.albums, toSection: albumSection)
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
    collectionsDataSource = DataSource(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, item in
      guard let strongSelf = self else {
        return UICollectionViewCell()
      }
      return strongSelf.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        item: item
      )
    }
    
    collectionsDataSource?.supplementaryViewProvider = { 
      [weak self] collectionView, kind, indexPath in
      guard let strongSelf = self else {
        return UICollectionReusableView()
      }
      return strongSelf.configureSupplementaryView(
        collectionView: collectionView,
        kind: kind,
        indexPath: indexPath
      )
    }
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    item: CollectionsItem
  ) -> UICollectionViewCell {
    let cell = UICollectionViewCell()
    let section = collectionsSections[indexPath.section]
    switch section {
    case .topics:
      if let topic = item.topic {
        return configureTopicCell(
          collectionView: collectionView,
          indexPath: indexPath,
          topic: topic
        )
      } else {
        return cell
      }
    case .albums:
      if let album = item.album {
        return configureAlbumCell(
          collectionView: collectionView,
          indexPath: indexPath,
          album: album
        )
      } else {
        return cell
      }
    }
  }
  
  private func configureSupplementaryView(
    collectionView: UICollectionView,
    kind: String,
    indexPath: IndexPath
  ) -> UICollectionReusableView {
    switch kind {
    case SupplementaryViewKind.header:
      return configureHeaderView(
        collectionView: collectionView,
        indexPath: indexPath
      )
    case SupplementaryViewKind.line:
      return configureLineView(
        collectionView: collectionView,
        kind: kind,
        indexPath: indexPath
      )
    default:
      return UICollectionReusableView()
    }
  }
  
  private func configureHeaderView(
    collectionView: UICollectionView,
    indexPath: IndexPath
  ) -> UICollectionReusableView {
    let section = collectionsSections[indexPath.section]
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
      headerView.setTitle(name)
      return headerView
    }
  }
  
  private func configureLineView(
    collectionView: UICollectionView,
    kind: String,
    indexPath: IndexPath
  ) -> UICollectionReusableView {
    let lineView = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: LineView.reuseID,
      for: indexPath
    )
    guard let lineView = lineView as? LineView else {
      return lineView
    }
    return lineView
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
    let viewModelItem = albumsViewModel.getViewModelItem(at: indexPath.item)
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
