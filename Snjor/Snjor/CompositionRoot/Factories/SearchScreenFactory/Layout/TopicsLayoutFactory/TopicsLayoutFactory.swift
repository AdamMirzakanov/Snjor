//
//  TopicsLayoutFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

fileprivate typealias Const = TopicsLayoutFactoryConst

/// `TopicsLayoutFactory` отвечает за создание
/// композитных макетов раздела Топиков для коллекционных представлений.
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
      widthDimension: .fractionalWidth(Const.itemWidthDimension),
      heightDimension: .fractionalHeight(Const.itemHeightDimension)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(
      top: .zero,
      leading: Const.smallValue,
      bottom: .zero,
      trailing: Const.smallValue
    )
    return item
  }
  
  private func makeGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(Const.groupWidthDimension),
      heightDimension: .estimated(Const.groupHeightDimension)
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
      top: Const.topSection,
      leading: Const.smallValue,
      bottom: Const.bottomSection,
      trailing: Const.smallValue
    )
    return section
  }
}
