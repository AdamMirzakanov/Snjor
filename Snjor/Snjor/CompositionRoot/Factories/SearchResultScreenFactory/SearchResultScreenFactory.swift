//
//  SearchResultScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

struct SearchResultScreenFactory: SearchResultScreenFactoryProtocol {
  
  // MARK: - Private Properties
  private let viewModelFactory: any SearchResultScreenViewModelFactoryProtocol
  private let layoutProvider: LayoutProvider
  
  // MARK: - Initializers
  init(
    viewModelFactory: any SearchResultScreenViewModelFactoryProtocol = SearchResultScreenViewModelFactory(),
    layoutProvider: LayoutProvider = LayoutProvider()
  ) {
    self.viewModelFactory = viewModelFactory
    self.layoutProvider = layoutProvider
  }
  
  // MARK: - Internal Methods
  func makeModule(
//    delegate: any SearchResultScreenViewControllerDelegate
  ) -> UIViewController {
    let module = getModule()
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
  
  func mekeTopicPhotosCoordinator(
    topic: Topic,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = TopicPhotosFactory(topic: topic)
    return TopicPhotosCoordinator(
      factory: factory,
      navigation: navigation,
      overlordCoordinator: overlordCoordinator
    )
  }
  
  func mekeAlbumPhotosCoordinator(
    album: Album,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = AlbumPhotosFactory(album: album)
    return AlbumPhotosCoordinator(
      factory: factory,
      navigation: navigation,
      overlordCoordinator: overlordCoordinator
    )
  }
  
  // MARK: - Private Methods
  private func getModule(
//    _ delegate: any SearchResultScreenViewControllerDelegate
  ) -> UIViewController {
    let photosViewModel = viewModelFactory.createPhotosViewModel()
//    let albumsViewModel = viewModelFactory.createAlbumsViewModel()
//    let topicsViewModel = viewModelFactory.createTopicsViewModel()
    let module = SearchResultScreenViewController(
      photosViewModel: photosViewModel
    )
    setupLayouts(module: module)
    return module
  }
  
  private func setupLayouts(module: SearchResultScreenViewController) {
    let cascadeLayout = MultiColumnCascadeLayout(with: module)
    module.rootView.photosCollectionView.collectionViewLayout = cascadeLayout
//    module.rootView.albumsCollectionView.collectionViewLayout = layoutProvider.createCollectionsLayout(module: module)
  }
}
