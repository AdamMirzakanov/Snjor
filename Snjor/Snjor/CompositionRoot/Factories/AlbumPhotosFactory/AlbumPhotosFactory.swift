//
//  AlbumPhotosFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit
import Combine

struct AlbumPhotosFactory: AlbumPhotosFactoryProtocol {
  
  // MARK: Internal Properties
  let album: Album
  
  // MARK: Internal Methods
  func makeController(
    delegate: any AlbumPhotosViewControllerDelegate
  ) -> UIViewController {
    let viewModel = createViewModel()
    let controller = createViewController(viewModel: viewModel, delegate: delegate)
    controller.navigationItem.title = album.title.uppercased()
    configureLayout(for: controller)
    return controller
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
      parentCoordinator: parentCoordinator
    )
    return coordinator
  }
  
  // MARK: Private Methods
  private func createViewModel() -> AlbumPhotosViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let repository = LoadAlbumPhotosRepository(networkService: networkService)
    let loadUseCase = LoadAlbumPhotosUseCase(repository: repository, album: album)
    return AlbumPhotosViewModel(
      loadUseCase: loadUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  private func createViewController(
    viewModel: AlbumPhotosViewModel,
    delegate: any AlbumPhotosViewControllerDelegate
  ) -> AlbumPhotosViewController {
    return AlbumPhotosViewController(
      viewModel: viewModel,
      delegate: delegate
    )
  }
  
  private func configureLayout(
    for controller: AlbumPhotosViewController
  ) {
    let cascadeLayout = MultiColumnCascadeLayout(with: controller)
    controller.rootView.albumPhotosCollectionView.collectionViewLayout = cascadeLayout
  }
}


