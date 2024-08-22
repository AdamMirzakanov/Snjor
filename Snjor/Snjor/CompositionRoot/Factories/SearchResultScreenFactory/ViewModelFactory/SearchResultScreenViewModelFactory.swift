//
//  SearchResultScreenViewModelFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import Combine

class SearchResultScreenViewModelFactory: SearchResultScreenViewModelFactoryProtocol {
  
  // MARK: - Private Properties
  private let networkService = NetworkService()
  private let lastPageValidationUseCase = LastPageValidationUseCase()
  private let state = PassthroughSubject<StateController, Never>()
  
  // MARK: - Internal Methods
  func createPhotosViewModel() -> SearchResultPhotosViewModel {
    let loadPhotosUseCase = getPhotosUseCase(networkService)
    let loadSearchPhotosUseCase = getSearchPhotosUseCase(networkService)
    return SearchResultPhotosViewModel(
      state: state,
      loadSearchPhotosUseCase: loadSearchPhotosUseCase,
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
  ) -> LoadSearchPhotosUseCase {
    let loadPhotosRepository = LoadSearchPhotosRepository(networkService: networkService)
    return LoadSearchPhotosUseCase(repository: loadPhotosRepository)
  }
  
  private func getSearchPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadSearchPhotosUseCase {
    let loadSearchPhotosRepository = LoadSearchPhotosRepository(networkService: networkService)
    return LoadSearchPhotosUseCase(repository: loadSearchPhotosRepository)
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

