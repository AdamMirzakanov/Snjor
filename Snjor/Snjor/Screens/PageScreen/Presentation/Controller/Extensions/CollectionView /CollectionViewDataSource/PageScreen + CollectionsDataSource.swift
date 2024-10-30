//
//  PageScreen + CollectionDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

extension PageScreenViewController {
  // MARK: Private Properties
  private var snapshot: TopicsSnapshot {
    var snapshot = TopicsSnapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.items)
    return snapshot
  }
  
  // MARK: Internal Methods
  func applySnapshot() {
    guard let dataSource = topicsDataSource else { return }
    dataSource.apply(
      snapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createDataSource(
    for collectionView: UICollectionView
  ) {
    topicsDataSource = TopicsDataSource(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, topicItem in
      return self?.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        topic: topicItem
      ) ?? UICollectionViewCell()
    }
  }
  
  // MARK: Configure Cells
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    topic: Topic
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PageScreenTopicCell.reuseID,
        for: indexPath
      ) as? PageScreenTopicCell
    else {
      return UICollectionViewCell()
    }
    let viewModelItem = viewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
