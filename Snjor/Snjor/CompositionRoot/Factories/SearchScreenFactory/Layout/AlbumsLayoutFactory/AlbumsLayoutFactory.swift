//
//  AlbumsLayoutFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

fileprivate typealias Const = AlbumsLayoutFactoryConst

struct AlbumsLayoutFactory {
  // MARK: Internal Methods
  func createAlbumLayout() -> NSCollectionLayoutSection {
    let item = makeItem()
    let verticalGroup = makeVerticalGroup(item: item)
    let section = makeSection(group: verticalGroup)
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
      leading: .zero,
      bottom: Const.itemBottomMargin,
      trailing: .zero
    )
    return item
  }
  
  private func makeVerticalGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(Const.groupWidthDimension),
      heightDimension: .fractionalWidth(Const.groupHeightDimension)
    )
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    horizontalGroup.interItemSpacing = .fixed(
      Const.horizontalGroupInterItemSpacing
    )
    let verticalGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: groupSize,
      subitems: [horizontalGroup]
    )
    return verticalGroup
  }

  private func makeSection(
    group: NSCollectionLayoutGroup
  ) -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(
      top: Const.sectionTopMargin,
      leading: Const.sectionMargin,
      bottom: .zero,
      trailing: Const.sectionMargin
    )
    return section
  }
}
