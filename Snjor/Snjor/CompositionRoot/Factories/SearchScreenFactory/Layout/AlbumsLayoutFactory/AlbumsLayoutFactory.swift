//
//  AlbumsLayoutFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

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
      widthDimension: .fractionalWidth(AlbumsLayoutFactoryConst.itemWidthDimension),
      heightDimension: .fractionalHeight(AlbumsLayoutFactoryConst.itemHeightDimension)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(
      top: .zero,
      leading: .zero,
      bottom: AlbumsLayoutFactoryConst.itemBottomMargin,
      trailing: .zero
    )
    return item
  }
  
  private func makeVerticalGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(AlbumsLayoutFactoryConst.groupWidthDimension),
      heightDimension: .fractionalWidth(AlbumsLayoutFactoryConst.groupHeightDimension)
    )
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    horizontalGroup.interItemSpacing = .fixed(
      AlbumsLayoutFactoryConst.horizontalGroupInterItemSpacing
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
      top: AlbumsLayoutFactoryConst.sectionTopMargin,
      leading: AlbumsLayoutFactoryConst.sectionMargin,
      bottom: .zero,
      trailing: AlbumsLayoutFactoryConst.sectionMargin
    )
    return section
  }
}
