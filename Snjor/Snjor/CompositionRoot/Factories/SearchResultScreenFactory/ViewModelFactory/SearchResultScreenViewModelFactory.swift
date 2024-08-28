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
  func createSearchPhotosViewModel() -> SearchResultPhotosViewModel {
    let loadSearchPhotosUseCase = getSearchPhotosUseCase(networkService)
    return SearchResultPhotosViewModel(
      state: state,
      loadSearchPhotosUseCase: loadSearchPhotosUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  func createSearchAlbumsViewModel() -> SearchResultAlbumsViewModel {
    let loadAlbumsUseCase = getSearchAlbumsUseCase(networkService)
    return SearchResultAlbumsViewModel(
      state: state,
      loadUseCase: loadAlbumsUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  // MARK: - Private Methods
  private func getSearchPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadSearchPhotosUseCase {
    let loadSearchPhotosRepository = LoadSearchPhotosRepository(networkService: networkService)
    return LoadSearchPhotosUseCase(repository: loadSearchPhotosRepository)
  }
  
  private func getSearchAlbumsUseCase(
    _ networkService: NetworkService
  ) -> LoadSearchAlbumsUseCase {
    let loadAlbumsRepository = LoadSearchAlbumsRepository(networkService: networkService)
    return LoadSearchAlbumsUseCase(repository: loadAlbumsRepository)
  }
}

