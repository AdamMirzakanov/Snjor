//
//  UserAlbumsLayoutFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import UIKit

fileprivate typealias Const = UserAlbumsLayoutFactoryConst

struct UserAlbumsLayoutFactory {
  // MARK: Internal Methods
  func createAlbumsLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      let section = createAlbumSection()
      return section
    }
    return layout
  }
  
  // MARK: Private Methods
  private func createAlbumSection() -> NSCollectionLayoutSection {
    let item = makeItem()
    let verticalGroup = makeGroup(item: item)
    let section = makeSection(group: verticalGroup)
    return section
  }
  
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
  
  private func makeGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(Const.groupWidthDimension),
      heightDimension: .fractionalWidth(Const.groupHeightDimension)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    group.interItemSpacing = .fixed(
      Const.groupInterItemSpacing
    )
    return group
  }

  private func makeSection(
    group: NSCollectionLayoutGroup
  ) -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(
      top: Const.sectionTopMargin,
      leading: .zero,
      bottom: .zero,
      trailing: .zero
    )
    return section
  }
}
