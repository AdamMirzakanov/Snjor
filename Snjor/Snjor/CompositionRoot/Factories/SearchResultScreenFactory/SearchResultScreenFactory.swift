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
  private let searchTerm: String
  
  // MARK: - Initializers
  init(
    viewModelFactory: any SearchResultScreenViewModelFactoryProtocol = SearchResultScreenViewModelFactory(),
    layoutProvider: LayoutProvider = LayoutProvider(),
    with searchTerm: String
  ) {
    self.viewModelFactory = viewModelFactory
    self.layoutProvider = layoutProvider
    self.searchTerm = searchTerm
  }
  
  // MARK: - Internal Methods
  func makeModule(
    delegate: any SearchResultScreenViewControllerDelegate
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
    _ delegate: any SearchResultScreenViewControllerDelegate
  ) -> UIViewController {
    let photosViewModel = viewModelFactory.createSearchPhotosViewModel()
    let albumsViewModel = viewModelFactory.createSearchAlbumsViewModel()
    let module = SearchResultScreenViewController(
      photosViewModel: photosViewModel, 
      albumsViewModel: albumsViewModel,
      delegate: delegate
    )
    setupLayouts(module: module)
    module.fetchMatchingItems(with: searchTerm)
    return module
  }
  
  private func setupLayouts(module: SearchResultScreenViewController) {
    let cascadeLayout = MultiColumnCascadeLayout(with: module)
    module.rootView.photosCollectionView.collectionViewLayout = cascadeLayout
    module.rootView.albumsCollectionView.collectionViewLayout = layoutProvider.createAlbumsLayout(module: module)
  }
}
