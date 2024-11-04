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
    let controller =  createViewController(viewModel: viewModel, delegate: delegate)
    controller.navigationItem.title = String(album.totalPhotos) + AlbumPhotosConst.photos
    controller.rootView.albumNameLable.text = album.title.uppercased()
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
    let controller = AlbumPhotosViewController(
      viewModel: viewModel,
      delegate: delegate
    )
    configureLayout(for: controller)
    return controller
  }
  
  private func configureLayout(
    for controller: AlbumPhotosViewController
  ) {
    let cascadeLayout = AlbumPhotosCascadeLayout(with: controller)
    controller.rootView.albumPhotosCollectionView.collectionViewLayout = cascadeLayout
  }
}

// MARK: - Const
enum AlbumPhotosConst {
  static let photos = " photos"
}
