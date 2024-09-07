//
//  SearchScreenViewController + TopicsAndAlbumsDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

extension SearchScreenViewController {
  // MARK: Private Properties
  private var collectionsSnapshot: TopicsAndAlbumsSnapshot {
    var snapshot = TopicsAndAlbumsSnapshot()
    let topicSection = TopicsAndAlbumsSection.topics
    let albumSection = TopicsAndAlbumsSection.albums(.albumsSectionName)
    snapshot.appendSections([topicSection, albumSection])
    snapshot.appendItems(CollectionsItem.topics, toSection: topicSection)
    snapshot.appendItems(CollectionsItem.albums, toSection: albumSection)
    collectionsSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: Internal Methods
  func applyCollectionsSnapshot() {
    guard let dataSource = topicsAndAlbumsDataSource else { return }
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
    topicsAndAlbumsDataSource = TopicsAndAlbumsDataSource(
      collectionView: collectionView
    ) { [weak self, weak delegate] collectionView, indexPath, item in
      let cell = UICollectionViewCell()
      guard
        let self = self,
        let delegate = delegate else {
        return cell
      }
      return self.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        item: item,
        delegate: delegate
      )
    }
    
    topicsAndAlbumsDataSource?.supplementaryViewProvider = {
      [weak self] collectionView, kind, indexPath in
      guard let self = self else {
        return UICollectionReusableView()
      }
      return self.configureSupplementaryView(
        collectionView: collectionView,
        kind: kind,
        indexPath: indexPath
      )
    }
  }
  
  // MARK: Configure Reusable Supplementary Views
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
  
  // MARK: Configure Cells
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    item: CollectionsItem,
    delegate: any AlbumCellDelegate
  ) -> UICollectionViewCell {
    let section = collectionsSections[indexPath.section]
    switch section {
    case .topics:
      return configureTopicCellIfNeeded(
        collectionView: collectionView,
        indexPath: indexPath,
        item: item
      )
    case .albums:
      return configureAlbumCellIfNeeded(
        collectionView: collectionView,
        indexPath: indexPath,
        item: item,
        delegate: delegate
      )
    }
  }
  
  private func configureTopicCellIfNeeded(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    item: CollectionsItem
  ) -> UICollectionViewCell {
    if let topic = item.topic {
      return configureTopicCell(
        collectionView: collectionView,
        indexPath: indexPath,
        topic: topic
      )
    } else {
      return UICollectionViewCell()
    }
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
    let viewModelItem = topicsViewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
  private func configureAlbumCellIfNeeded(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    item: CollectionsItem,
    delegate: any AlbumCellDelegate
  ) -> UICollectionViewCell {
    if let album = item.album {
      return configureAlbumCell(
        collectionView: collectionView,
        indexPath: indexPath,
        album: album,
        delegate: delegate
      )
    } else {
      return UICollectionViewCell()
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
    cell.delegate = delegate
    let viewModelItem = albumsViewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
