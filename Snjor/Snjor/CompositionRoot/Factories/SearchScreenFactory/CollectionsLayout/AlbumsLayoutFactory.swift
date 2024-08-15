//
//  AlbumsLayoutFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

struct AlbumsLayoutFactory {

  // MARK: - Internal Methods
  func createAlbumLayout() -> NSCollectionLayoutSection {
    let item = makeItem()
    let verticalGroup = makeVerticalGroup(item: item)
    let section = makeSection(group: verticalGroup)
    return section
  }
  
  // MARK: - Private Methods
  private func makeItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.5),
      heightDimension: .fractionalHeight(1)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(
      top: .zero,
      leading: 4.0,
      bottom: 32,
      trailing: 4.0
    )
    return item
  }
  
  private func makeVerticalGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalWidth(0.63)
    )
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
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
      top: 24.0,
      leading: 4.0,
      bottom: .zero,
      trailing: 4.0
    )
    return section
  }
}
