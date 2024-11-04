//
//  SearchScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

struct SearchScreenFactory: SearchScreenFactoryProtocol {
  // MARK: Private Properties
  private let viewModelProvider: any SearchScreenViewModelProviderProtocol
  private let layoutProvider: LayoutProvider
  
  // MARK: Initializers
  init(
    viewModelProvider: any SearchScreenViewModelProviderProtocol = SearchScreenViewModelProvider(),
    layoutProvider: LayoutProvider = LayoutProvider()
  ) {
    self.viewModelProvider = viewModelProvider
    self.layoutProvider = layoutProvider
  }
  
  // MARK: Internal Methods
  func makeController(
    delegate: any SearchScreenViewControllerDelegate
  ) -> UIViewController {
    return getController(delegate)
  }
  
  func makePhotoDetailCoordinator(
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
  
  func makeTopicPhotosCoordinator(
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
  
  func makeAlbumPhotosCoordinator(
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
  
  func makeUserProfileCoordinator(
    user: User,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = UserProfileFactory(user: user)
    return UserProfileCoordinator(
      factory: factory,
      navigation: navigation,
      parentCoordinator: parentCoordinator
    )
  }
  
  // MARK: Private Methods
  private func getController(
    _ delegate: any SearchScreenViewControllerDelegate
  ) -> UIViewController {
    let photosViewModel = viewModelProvider.createPhotosViewModel()
    let albumsViewModel = viewModelProvider.createAlbumsViewModel()
    let topicsViewModel = viewModelProvider.createTopicsViewModel()
    let usersViewModel = viewModelProvider.createUsersViewModel()
    let controller = SearchScreenViewController(
      photosViewModel: photosViewModel,
      albumsViewModel: albumsViewModel, 
      topicsViewModel: topicsViewModel,
      usersViewModel: usersViewModel,
      delegate: delegate
    )
    setupLayouts(controller)
    return controller
  }
  
  private func setupLayouts(_ controller: SearchScreenViewController) {
    let cascadeLayout = CascadeLayout(with: controller)
    controller.rootView.photosCollectionView.collectionViewLayout = cascadeLayout
    let collectionsLayout = layoutProvider.createCollectionsLayout(controller)
    controller.rootView.topicsAndAlbumsCollectionView.collectionViewLayout = collectionsLayout
  }
}
