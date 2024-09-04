//
//  TopicsLayoutFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

struct TopicsLayoutFactory {
  
  // MARK: Internal Methods
  func createTopicLayout() -> NSCollectionLayoutSection {
    let item = makeItem()
    let group = makeGroup(item: item)
    let section = makeSection(group: group)
    return section
  }
  
  // MARK: Private Methods
  private func makeItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(TopicsLayoutFactoryConst.itemWidthDimension),
      heightDimension: .fractionalHeight(TopicsLayoutFactoryConst.itemHeightDimension)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(
      top: .zero,
      leading: TopicsLayoutFactoryConst.smallValue,
      bottom: .zero,
      trailing: TopicsLayoutFactoryConst.smallValue
    )
    return item
  }
  
  private func makeGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(TopicsLayoutFactoryConst.groupWidthDimension),
      heightDimension: .estimated(TopicsLayoutFactoryConst.groupHeightDimension)
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
      top: TopicsLayoutFactoryConst.topSection,
      leading: TopicsLayoutFactoryConst.smallValue,
      bottom: TopicsLayoutFactoryConst.bottomSection,
      trailing: TopicsLayoutFactoryConst.smallValue
    )
    return section
  }
}
