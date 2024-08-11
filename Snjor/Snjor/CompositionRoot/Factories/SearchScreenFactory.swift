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
    let module = SearchScreenViewController(
      photosViewModel: photosViewModel,
      albumsViewModel: albumsViewModel,
      delegate: delegate
    )
    setupLayouts(module: module)
    return module
  }
  
  private func setupLayouts(module: SearchScreenViewController) {
    let cascadeLayout = MultiColumnCascadeLayout(with: module)
    module.rootView.photosCollectionView.collectionViewLayout = cascadeLayout
    module.rootView.albumsCollectionView.collectionViewLayout = createAlbumLayout()
  }
  
  // MARK: - Create Album Layout
  private func createAlbumLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (
      sectionIndex, layoutEnvironment
    ) -> NSCollectionLayoutSection? in
      let item = makeItem()
      let verticalGroup = makeVerticalGroup(item: item)
      let section = makeSection(group: verticalGroup)
      return section
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
      leading: 4.0,
      bottom: 4.0 * 2.0,
      trailing: 4.0
    )
    return item
  }
  
  private func makeVerticalGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalWidth(0.5)
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
      leading: 4.0 * 4.0,
      bottom: 0,
      trailing: 4.0 * 4.0
    )
    return section
  }
}
