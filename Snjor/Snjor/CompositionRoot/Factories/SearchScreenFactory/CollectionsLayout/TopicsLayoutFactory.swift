//
//  TopicsLayoutFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

struct TopicsLayoutFactory {
  // MARK: - Internal Methods
  func createTopicLayout() -> NSCollectionLayoutSection {
    let item = makeItem()
    let group = makeGroup(item: item)
    let section = makeSection(group: group)
    return section
  }
  
  // MARK: - Private Methods
  private func makeItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(0.5)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(
      top: .zero,
      leading: 4.0,
      bottom: .zero,
      trailing: 4.0
    )
    return item
  }
  
  private func makeGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.94),
      heightDimension: .estimated(400)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    return group
  }
  
  private func makeSection(
    group: NSCollectionLayoutGroup
  ) -> NSCollectionLayoutSection  {
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPagingCentered
    section.contentInsets = NSDirectionalEdgeInsets(
      top: 6.0,
      leading: 4.0,
      bottom: 4.0 * 5,
      trailing: 4.0
    )
    return section
  }
}
