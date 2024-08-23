//
//  SearchScreenViewModelFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

import Combine

class SearchScreenViewModelFactory: SearchScreenViewModelFactoryProtocol {
  
  // MARK: - Private Properties
  private let networkService = NetworkService()
  private let lastPageValidationUseCase = LastPageValidationUseCase()
  private let state = PassthroughSubject<StateController, Never>()
  
  // MARK: - Internal Methods
  func createPhotosViewModel() -> PhotosViewModel {
    let loadPhotosUseCase = getPhotosUseCase(networkService)
    return PhotosViewModel(
      state: state,
      loadUseCase: loadPhotosUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  func createAlbumsViewModel() -> AlbumsViewModel {
    let loadAlbumsUseCase = getAlbumsUseCase(networkService)
    return AlbumsViewModel(
      state: state,
      loadUseCase: loadAlbumsUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  func createTopicsViewModel() -> TopicsViewModel {
    let loadTopicsUseCase = getTopicsUseCase(networkService)
    return TopicsViewModel(state: state, loadUseCase: loadTopicsUseCase)
  }
  
  // MARK: - Private Methods
  private func getPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadPhotosUseCase {
    let loadPhotosRepository = LoadPhotosRepository(networkService: networkService)
    return LoadPhotosUseCase(repository: loadPhotosRepository)
  }
  
  private func getAlbumsUseCase(
    _ networkService: NetworkService
  ) -> LoadAlbumsUseCase {
    let loadAlbumsRepository = LoadAlbumsRepository(networkService: networkService)
    return LoadAlbumsUseCase(repository: loadAlbumsRepository)
  }
  
  private func getTopicsUseCase(
    _ networkService: NetworkService
  ) -> LoadTopicsUseCase {
    let loadTopicsRepository = LoadTopicsPageRepository(networkService: networkService)
    return LoadTopicsUseCase(repository: loadTopicsRepository)
  }
}
