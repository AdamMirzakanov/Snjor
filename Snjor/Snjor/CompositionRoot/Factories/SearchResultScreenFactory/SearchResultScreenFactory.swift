//
//  SearchResultScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

struct SearchResultScreenFactory: SearchResultScreenFactoryProtocol {
  // MARK: Private Properties
  private let viewModelProvider: any SearchScreenViewModelProviderProtocol
  private let layoutProvider: LayoutProvider
  private let searchTerm: String
  private let currentScopeIndex: Int
  
  // MARK: Initializers
  init(
    currentScopeIndex: Int,
    viewModelFactory: any SearchScreenViewModelProviderProtocol = SearchScreenViewModelProvider(),
    layoutProvider: LayoutProvider = LayoutProvider(),
    with searchTerm: String
  ) {
    self.currentScopeIndex = currentScopeIndex
    self.viewModelProvider = viewModelFactory
    self.layoutProvider = layoutProvider
    self.searchTerm = searchTerm
  }
  
  // MARK: Internal Methods
  func makeController(
    delegate: any SearchResultViewControllerDelegate
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
    _ delegate: any SearchResultViewControllerDelegate
  ) -> SearchResultViewController {
    let photosViewModel = viewModelProvider.createPhotosViewModel()
    let albumsViewModel = viewModelProvider.createAlbumsViewModel()
    let usersViewModel = viewModelProvider.createUsersViewModel()
    let controller = SearchResultViewController(
      currentScopeIndex: currentScopeIndex,
      photosViewModel: photosViewModel,
      albumsViewModel: albumsViewModel, 
      usersViewModel: usersViewModel,
      delegate: delegate
    )
    setupLayouts(controller)
    controller.fetchMatchingItems(with: searchTerm)
    return controller
  }
  
  private func setupLayouts(_ controller: SearchResultViewController) {
    let cascadeLayout = MultiColumnCascadeLayout(with: controller)
    controller.rootView.photosCollectionView.collectionViewLayout = cascadeLayout
    let albumsLayout = layoutProvider.createAlbumsLayout(controller)
    controller.rootView.albumsCollectionView.collectionViewLayout = albumsLayout
  }
}
