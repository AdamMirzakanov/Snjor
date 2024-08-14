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
      
      let section = module.albumsSections[sectionIndex]
      
      switch section {
        
      case .topics:
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalHeight(0.5)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(
          top: 0,
          leading: 4.0,
          bottom: 0,
          trailing: 4.0
        )
        
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(0.92),
          heightDimension: .estimated(300)
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
          bottom: 4.0 * 5, trailing: 4.0
        )
        return section
      case .albums:
        let item = makeItem()
        let verticalGroup = makeVerticalGroup(item: item)
        let section = makeSection(group: verticalGroup)
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
      top: 20,
      leading: 4.0,
      bottom: 8.0,
      trailing: 4.0
    )
    return item
  }
  
  private func makeVerticalGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalWidth(0.6)
    )
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: item,
      count: 2
    )
    let verticalGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: groupSize,
      subitems: [horizontalGroup, horizontalGroup]
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
