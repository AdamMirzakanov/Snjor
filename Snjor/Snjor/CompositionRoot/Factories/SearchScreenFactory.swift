//
//  SearchScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit
import Combine

protocol SearchScreenFactoryProtocol {
  func makeModule(
    delegate: any PhotosCollectionViewControllerDelegate
  ) -> UIViewController
  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable
}

struct SearchScreenFactory: SearchScreenFactoryProtocol {
  
  // MARK: - Private Properties
  private let viewModelFactory: ViewModelFactory
  
  // MARK: - Initializers
  init(viewModelFactory: ViewModelFactory = ViewModelFactory()) {
    self.viewModelFactory = viewModelFactory
  }
  
  // MARK: - Internal Methods
  func makeModule(
    delegate: any PhotosCollectionViewControllerDelegate
  ) -> UIViewController {
    let module = getModule(delegate)
    return module
  }
  
  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = PhotoDetailFactory(photo: photo)
    return PhotoDetailCoordinator(
      factory: factory,
      navigation: navigation,
      overlordCoordinator: overlordCoordinator
    )
  }
  
  // MARK: - Private Methods
  private func getModule(
    _ delegate: any PhotosCollectionViewControllerDelegate
  ) -> UIViewController {
    let photosViewModel = viewModelFactory.createPhotosViewModel()
    let albumsViewModel = viewModelFactory.createAlbumsViewModel()
    let topicsViewModel = viewModelFactory.createTopicsViewModel()
    let module = SearchScreenViewController(
      photosViewModel: photosViewModel,
      albumsViewModel: albumsViewModel, 
      topicsViewModel: topicsViewModel,
      delegate: delegate
    )
    setupLayouts(module: module)
    return module
  }
  
  private func setupLayouts(module: SearchScreenViewController) {
    let cascadeLayout = MultiColumnCascadeLayout(with: module)
    module.rootView.photosCollectionView.collectionViewLayout = cascadeLayout
    module.rootView.albumsCollectionView.collectionViewLayout = createAlbumLayout(module: module)
  }
  
  // MARK: - Create Album Layout
  private func createAlbumLayout(
    module: SearchScreenViewController
  ) -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (
      sectionIndex, layoutEnvironment
    ) -> NSCollectionLayoutSection? in
      
      // MARK: - Внешние линии разделов
      let lineItemHeight = 1 / layoutEnvironment.traitCollection.displayScale
      let lineItemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.88),
        heightDimension: .absolute(lineItemHeight)
      )
      
      // отступы вокруг
      let supplementaryItemContentInsets = NSDirectionalEdgeInsets(
        top: 0,
        leading: 0,
        bottom: 0,
        trailing: 0
      )
      
      // верхня линия
      let topLineItem = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: lineItemSize,
        elementKind: SupplementaryViewKind.topLine,
        alignment: .top
      )
      topLineItem.contentInsets = supplementaryItemContentInsets
      
      // нижня линия
      let bottomLineItem = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: lineItemSize,
        elementKind: SupplementaryViewKind.bottomLine,
        alignment: .bottom
      )
      bottomLineItem.contentInsets = supplementaryItemContentInsets
      
      
      // MARK: - Заголовок
      let headerItemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.92),
        heightDimension: .estimated(44)
      )
      
      let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: headerItemSize,
        elementKind: SupplementaryViewKind.header,
        alignment: .top
      )
      
      let section = module.albumsSections[sectionIndex]
      
      switch section {
        
      case .topics:
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalHeight(0.5)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(
          top: 8,
          leading: 4.0,
          bottom: 0,
          trailing: 4.0
        )
        
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(0.92),
          heightDimension: .estimated(270)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
          layoutSize: groupSize,
          subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(
          top: 0,
          leading: 4.0,
          bottom: 4.0 * 5,
          trailing: 4.0
        )
        section.boundarySupplementaryItems = [headerItem, bottomLineItem]
        return section
      case .albums:
        let item = makeItem()
        let verticalGroup = makeVerticalGroup(item: item)
        let section = makeSection(group: verticalGroup)
        section.boundarySupplementaryItems = [headerItem]
        return section
      }
    }
    return layout
  }
  
  private func makeItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(
      top: 0,
      leading: 0,
      bottom: 0,
      trailing: 0
    )
    return item
  }
  
  private func makeVerticalGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalWidth(0.53)
    )
    
    
    
    // Создаем элементы с размером, чтобы они занимали половину ширины горизонтальной группы
    let horizontalItemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.5),
      heightDimension: .fractionalHeight(1)
    )
    
    let horizontalItem = NSCollectionLayoutItem(layoutSize: horizontalItemSize)
    
    horizontalItem.contentInsets = NSDirectionalEdgeInsets(
      top: 24,
      leading: 4.0,
      bottom: 2,
      trailing: 4.0
    )
    
    // Создаем горизонтальную группу с двумя элементами
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [horizontalItem]
    )
    
    // Создаем вертикальную группу, содержащую две горизонтальные группы
    let verticalGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: groupSize,
      subitems: [horizontalGroup]
    )
    
    return verticalGroup
  }

  
  private func makeSection(group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(
      top: 0,
      leading: 16.0,
      bottom: 0,
      trailing: 16.0
    )
    return section
  }
}

enum SupplementaryViewKind {
  static let header = "header"
  static let topLine = "topLine"
  static let bottomLine = "bottomLine"
}
