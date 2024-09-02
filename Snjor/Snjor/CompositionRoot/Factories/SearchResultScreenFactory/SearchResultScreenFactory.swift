//
//  SearchResultScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

struct SearchResultScreenFactory: SearchResultScreenFactoryProtocol {
  
  // MARK: - Private Properties
  private let viewModelFactory: any SearchScreenViewModelFactoryProtocol
  private let layoutProvider: LayoutProvider
  private let searchTerm: String
  private let currentScopeIndex: Int
  
  // MARK: - Initializers
  init(
    currentScopeIndex: Int,
    viewModelFactory: any SearchScreenViewModelFactoryProtocol = SearchScreenViewModelFactory(),
    layoutProvider: LayoutProvider = LayoutProvider(),
    with searchTerm: String
  ) {
    self.currentScopeIndex = currentScopeIndex
    self.viewModelFactory = viewModelFactory
    self.layoutProvider = layoutProvider
    self.searchTerm = searchTerm
  }
  
  // MARK: - Internal Methods
  func makeModule(
    delegate: any SearchResultViewControllerDelegate
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
    _ delegate: any SearchResultViewControllerDelegate
  ) -> UIViewController {
    let photosViewModel = viewModelFactory.createPhotosViewModel()
    let albumsViewModel = viewModelFactory.createAlbumsViewModel()
    let module = SearchResultViewController(
      currentScopeIndex: currentScopeIndex,
      photosViewModel: photosViewModel,
      albumsViewModel: albumsViewModel,
      delegate: delegate
    )
    setupLayouts(module: module)
    module.fetchMatchingItems(with: searchTerm)
    return module
  }
  
  private func setupLayouts(module: SearchResultViewController) {
    let cascadeLayout = MultiColumnCascadeLayout(with: module)
    module.rootView.photosCollectionView.collectionViewLayout = cascadeLayout
    module.rootView.albumsCollectionView.collectionViewLayout = layoutProvider.createAlbumsLayout(module: module)
  }
}
