//
//  UserProfileCollectionViewLayoutFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileCollectionViewLayoutFactoryConst

// MARK: - Section
enum UserProfileSection: Hashable {
  case main
}

// MARK: - Class
struct UserProfileCollectionViewLayoutFactory {
  // MARK: Internal Properties
  var userProfileSection: [UserProfileSection] = [.main]

  // MARK: Internal Methods
  func createUserProfileCollecitonViewLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      let section = userProfileSection[sectionIndex]
      switch section {
      case .main:
        let section = createUserProfileSection()
        return section
      }
    }
    return layout
  }
  
  // MARK: Private Methods
  private func createUserProfileSection() -> NSCollectionLayoutSection {
    let item = makeItem()
    let group = makeGroup(item: item)
    let section = makeSection(group: group)
    return section
  }
  
  private func makeItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(Const.itemWidthDimension),
      heightDimension: .fractionalHeight(Const.itemHeightDimension)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
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
    section.interGroupSpacing = Const.interGroupSpacing
    return section
  }
}
