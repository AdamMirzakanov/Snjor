//
//  SearchScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

struct SearchScreenFactory: SearchScreenFactoryProtocol {
  
  // MARK: Private Properties
  private let viewModelFactory: any SearchScreenViewModelProviderProtocol
  private let layoutProvider: LayoutProvider
  
  // MARK: Initializers
  init(
    viewModelFactory: any SearchScreenViewModelProviderProtocol = SearchScreenViewModelProvider(),
    layoutProvider: LayoutProvider = LayoutProvider()
  ) {
    self.viewModelFactory = viewModelFactory
    self.layoutProvider = layoutProvider
  }
  
  // MARK: Internal Methods
  func makeController(
    delegate: any SearchScreenViewControllerDelegate
  ) -> UIViewController {
    return getController(delegate)
  }
  
  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = PhotoDetailFactory(photo: photo)
    return PhotoDetailCoordinator(
      factory: factory,
      navigation: navigation,
      parentCoordinator: parentCoordinator
    )
  }
  
  func mekeTopicPhotosCoordinator(
    topic: Topic,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = TopicPhotosFactory(topic: topic)
    return TopicPhotosCoordinator(
      factory: factory,
      navigation: navigation,
      parentCoordinator: parentCoordinator
    )
  }
  
  func mekeAlbumPhotosCoordinator(
    album: Album,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = AlbumPhotosFactory(album: album)
    return AlbumPhotosCoordinator(
      factory: factory,
      navigation: navigation,
      parentCoordinator: parentCoordinator
    )
  }
  
  func makeSearchResultScreenCoordinator(
    currentScopeIndex: Int,
    with searchTerm: String,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = SearchResultScreenFactory(
      currentScopeIndex: currentScopeIndex,
      with: searchTerm
    )
    return SearchResultScreenCoordinator(
      factory: factory,
      navigation: navigation,
      parentCoordinator: parentCoordinator
    )
  }
  
  // MARK: Private Methods
  private func getController(
    _ delegate: any SearchScreenViewControllerDelegate
  ) -> UIViewController {
    let photosViewModel = viewModelFactory.createPhotosViewModel()
    let albumsViewModel = viewModelFactory.createAlbumsViewModel()
    let topicsViewModel = viewModelFactory.createTopicsViewModel()
    let controller = SearchScreenViewController(
      photosViewModel: photosViewModel,
      albumsViewModel: albumsViewModel, 
      topicsViewModel: topicsViewModel,
      delegate: delegate
    )
    setupLayouts(controller)
    return controller
  }
  
  private func setupLayouts(_ controller: SearchScreenViewController) {
    let cascadeLayout = MultiColumnCascadeLayout(with: controller)
    controller.rootView.photosCollectionView.collectionViewLayout = cascadeLayout
    let collectionsLayout = layoutProvider.createCollectionsLayout(controller)
    controller.rootView.albumsCollectionView.collectionViewLayout = collectionsLayout
  }
}
