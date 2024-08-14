//
//  SearchScreenViewController + TopicsDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.08.2024.
//

import UIKit

extension SearchScreenViewController {
  
  func createTopicDataSource(
    for collectionView: UICollectionView
  ) {
    collectionsDataSource = UICollectionViewDiffableDataSource<CollectionsSection, Item>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, topicItem in
      return self?.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        topic: topicItem.topic!
      ) ?? UICollectionViewCell()
    }
  }
  
  func applyTopicSnapshot() {
    guard let dataSource = collectionsDataSource else { return }
    dataSource.apply(
      collectionsSnapshot,
      animatingDifferences: true
    )
  }
  
  private func configureCell(
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
