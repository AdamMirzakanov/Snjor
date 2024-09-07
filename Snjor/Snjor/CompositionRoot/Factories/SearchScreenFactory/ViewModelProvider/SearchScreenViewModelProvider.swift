//
//  SearchScreenViewModelProvider.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

import Combine

final class SearchScreenViewModelProvider: SearchScreenViewModelProviderProtocol {
  // MARK: Private Properties
  private let networkService = NetworkService()
  private let lastPageValidationUseCase = LastPageValidationUseCase()
  private let state = PassthroughSubject<StateController, Never>()
  
  // MARK: Internal Methods
  func createPhotosViewModel() -> DiscoverViewModel {
    let loadPhotosUseCase = getPhotosUseCase(networkService)
    let loadSearchPhotosUseCase = getSearchPhotosUseCase(networkService)
    return DiscoverViewModel(
      loadUseCase: loadPhotosUseCase,
      loadSearchPhotosUseCase: loadSearchPhotosUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  func createAlbumsViewModel() -> AlbumsViewModel {
    let loadAlbumsUseCase = getAlbumsUseCase(networkService)
    let loadSearchAlbumsUseCase = getSearchAlbumsUseCase(networkService)
    return AlbumsViewModel(
      loadUseCase: loadAlbumsUseCase,
      loadSearchPhotosUseCase: loadSearchAlbumsUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  func createTopicsViewModel() -> TopicsViewModel {
    let loadTopicsUseCase = getTopicsUseCase(networkService)
    return TopicsViewModel(
      loadUseCase: loadTopicsUseCase,
      state: state
    )
  }
  
  // MARK: Private Methods
  private func getPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadPhotosUseCase {
    let loadPhotosRepository = LoadPhotosRepository(networkService: networkService)
    return LoadPhotosUseCase(repository: loadPhotosRepository)
  }
  
  private func getSearchPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadSearchPhotosUseCase {
    let loadPhotosRepository = LoadSearchPhotosRepository(networkService: networkService)
    return LoadSearchPhotosUseCase(repository: loadPhotosRepository)
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
  
  private func getSearchAlbumsUseCase(
    _ networkService: NetworkService
  ) -> LoadSearchAlbumsUseCase {
    let loadAlbumsRepository = LoadSearchAlbumsRepository(networkService: networkService)
    return LoadSearchAlbumsUseCase(repository: loadAlbumsRepository)
  }
}
