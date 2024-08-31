//
//  LayoutProvider.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

struct LayoutProvider {
  
  // MARK: - Private Properties
  private let albumsLayoutFactory = AlbumsLayoutFactory()
  private let topicsLayoutFactory = TopicsLayoutFactory()
  
  // MARK: - Internal Methods
  func createCollectionsLayout(
    module: SearchScreenViewController
  ) -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      let section = module.collectionsSections[sectionIndex]
      switch section {
      case .topics:
        let lineItem = makeLineItem(layoutEnvironment: layoutEnvironment)
        let section = topicsLayoutFactory.createTopicLayout()
        section.boundarySupplementaryItems = [lineItem]
        return section
      case .albums:
        let headerItem = makeHeaderItem()
        let section = albumsLayoutFactory.createAlbumLayout()
        section.boundarySupplementaryItems = [headerItem]
        return section
      }
    }
    return layout
  }
  
  func createAlbumsLayout(
    module: SearchResultScreenViewController
  ) -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { [weak module] (
      sectionIndex, layoutEnvironment
    ) in
      let section = module?.collectionsSections[sectionIndex]
      switch section {
      case .albums:
        let section = albumsLayoutFactory.createAlbumLayout()
        return section
      default:
        let section = albumsLayoutFactory.createAlbumLayout()
        return section
      }
    }
    return layout
  }
  
  // MARK: - Private Methods
  private func makeLineItem(
    layoutEnvironment: any NSCollectionLayoutEnvironment
  ) -> NSCollectionLayoutBoundarySupplementaryItem {
    let lineItemHeight = 1 / layoutEnvironment.traitCollection.displayScale
    let lineItemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.88),
      heightDimension: .absolute(lineItemHeight)
    )
    return NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: lineItemSize,
      elementKind: SupplementaryViewKind.line,
      alignment: .bottom
    )
  }
  
  private func makeHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
    let headerItemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.92),
      heightDimension: .estimated(44)
    )
    return NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerItemSize,
      elementKind: SupplementaryViewKind.header,
      alignment: .top
    )
  }
}
