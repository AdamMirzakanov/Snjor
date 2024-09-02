//
//  AlbumPhotosFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit
import Combine

struct AlbumPhotosFactory: AlbumPhotosFactoryProtocol {
  
  // MARK: - Internal Properties
  let album: Album
  
  // MARK: - Internal Methods
  func makeModule(
    delegate: any AlbumPhotosViewControllerDelegate
  ) -> UIViewController {
    let viewModel = createViewModel()
    let module = createViewController(viewModel: viewModel, delegate: delegate)
    module.navigationItem.title = album.title.uppercased()
    configureLayout(for: module)
    return module
  }
  
  func makePhotoDetailCoordinator(
    navigation: any Navigable,
    photo: Photo,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = PhotoDetailFactory(photo: photo)
    let coordinator = PhotoDetailCoordinator(
      factory: factory,
      navigation: navigation,
      overlordCoordinator: parentCoordinator
    )
    return coordinator
  }
  
  // MARK: - Private Methods
  private func createViewModel() -> OldAlbumPhotosViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let repository = LoadAlbumPhotosRepository(networkService: networkService)
    let loadUseCase = LoadAlbumPhotosUseCase(repository: repository, album: album)
    return OldAlbumPhotosViewModel(
      state: state,
      loadUseCase: loadUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  private func createViewController(
    viewModel: OldAlbumPhotosViewModel,
    delegate: any AlbumPhotosViewControllerDelegate
  ) -> AlbumPhotosViewController {
    let module = AlbumPhotosViewController(
      viewModel: viewModel,
      delegate: delegate
    )
    return module
  }
  
  private func configureLayout(
    for module: AlbumPhotosViewController
  ) {
    let cascadeLayout = MultiColumnCascadeLayout(with: module)
    module.rootView.albumPhotosCollectionView.collectionViewLayout = cascadeLayout
  }
}


