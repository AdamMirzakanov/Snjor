//
//  SearchScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

struct SearchScreenFactory: SearchScreenFactoryProtocol {
  
  // MARK: - Private Properties
  private let viewModelFactory: any SearchScreenViewModelFactoryProtocol
  private let layoutProvider: LayoutProvider
  
  // MARK: - Initializers
  init(
    viewModelFactory: any SearchScreenViewModelFactoryProtocol = SearchScreenViewModelFactory(),
    layoutProvider: LayoutProvider = LayoutProvider()
  ) {
    self.viewModelFactory = viewModelFactory
    self.layoutProvider = layoutProvider
  }
  
  // MARK: - Internal Methods
  func makeModule(
    delegate: any SearchScreenViewControllerDelegate
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
  
  func makeSearchResultScreenCoordinator(
    currentScopeIndex: Int,
    with searchTerm: String,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = SearchResultScreenFactory(
      currentScopeIndex: currentScopeIndex,
      with: searchTerm
    )
    return SearchResultScreenCoordinator(
      factory: factory,
      navigation: navigation,
      overlordCoordinator: overlordCoordinator
    )
  }
  
  // MARK: - Private Methods
  private func getModule(
    _ delegate: any SearchScreenViewControllerDelegate
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
    module.rootView.albumsCollectionView.collectionViewLayout = layoutProvider.createCollectionsLayout(module: module)
  }
}
