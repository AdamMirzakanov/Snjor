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
  func createAlbumsViewModel() -> AlbumsViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let loadAlbumsUseCase = getAlbumsUseCase(networkService)
    return AlbumsViewModel(
      state: state,
      loadUseCase: loadAlbumsUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  func createTopicsViewModel() -> TopicsPageViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let loadTopicsUseCase = getTopicsUseCase(networkService)
    return TopicsPageViewModel(
      state: state,
      loadUseCase: loadTopicsUseCase
    )
  }
  
  private func getPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadPhotosUseCase {
    let loadPhotosRepository = LoadPhotosRepository(
      networkService: networkService
    )
    return LoadPhotosUseCase(repository: loadPhotosRepository)
  }
  
  private func getAlbumsUseCase(
    _ networkService: NetworkService
  ) -> LoadAlbumsUseCase {
    let loadAlbumsRepository = LoadAlbumsRepository(
      networkService: networkService
    )
    return LoadAlbumsUseCase(repository: loadAlbumsRepository)
  }
  
  private func getTopicsUseCase(
    _ networkService: NetworkService
  ) -> LoadTopicsPageUseCase {
    let loadTopicsRepository = LoadTopicsPageRepository(
      networkService: networkService
    )
    return LoadTopicsPageUseCase(repository: loadTopicsRepository)
  }
}
