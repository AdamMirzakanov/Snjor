//
//  PageScreen + CollectionDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

extension PageScreenViewController {
  
  private typealias DataSource = UICollectionViewDiffableDataSource <TopicsSection, Topic>
  private typealias Snapshot = NSDiffableDataSourceSnapshot <TopicsSection, Topic>
  
  // MARK: Private Properties
  private var snapshot: Snapshot {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.items)
    return snapshot
  }
  
  // MARK: Internal Methods
  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(
      snapshot,
      animatingDifferences: true
    )
  }
  
  func createDataSource(
    for collectionView: UICollectionView
  ) {
    dataSource = DataSource(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, topicItem in
      return self?.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        topic: topicItem
      ) ?? UICollectionViewCell()
    }
  }
  
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
