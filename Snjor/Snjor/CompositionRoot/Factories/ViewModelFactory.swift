//
//  ViewModelFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

import Combine

class ViewModelFactory {
  
  // MARK: - Internal Methods
  func createPhotosViewModel() -> PhotosViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let loadPhotosUseCase = getPhotosUseCase(networkService)
    return PhotosViewModel(
      state: state,
      loadUseCase: loadPhotosUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  // MARK: - Private Methods
  func createAlbumsViewModel() -> AlbumListViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let loadAlbumsUseCase = getAlbumsUseCase(networkService)
    return AlbumListViewModel(
      state: state,
      loadUseCase: loadAlbumsUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  private func getPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadPhotoListUseCase {
    let loadPhotosRepository = LoadPhotoListRepository(
      networkService: networkService
    )
    return LoadPhotoListUseCase(repository: loadPhotosRepository)
  }
  
  private func getAlbumsUseCase(
    _ networkService: NetworkService
  ) -> LoadAlbumListUseCase {
    let loadAlbumsRepository = LoadAlbumListRepository(
      networkService: networkService
    )
    return LoadAlbumListUseCase(repository: loadAlbumsRepository)
  }
}
