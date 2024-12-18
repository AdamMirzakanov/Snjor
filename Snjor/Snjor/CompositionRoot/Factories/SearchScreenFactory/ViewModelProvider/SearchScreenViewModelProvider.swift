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
  
  func createTopicsViewModel() -> TopicsViewModel {
    let loadTopicsUseCase = getTopicsUseCase(networkService)
    return TopicsViewModel(
      loadUseCase: loadTopicsUseCase,
      state: state
    )
  }
  
  func createAlbumsViewModel() -> AlbumsViewModel {
    let loadAlbumsUseCase = getAlbumsUseCase(networkService)
    let loadSearchAlbumsUseCase = getSearchAlbumsUseCase(networkService)
    return AlbumsViewModel(
      loadUseCase: loadAlbumsUseCase,
      loadSearchAlbumsUseCase: loadSearchAlbumsUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  func createUsersViewModel() -> UsersViewModel {
    let loadSearchUsersUseCase = getSearchUsersUseCase(networkService)
    return UsersViewModel(
      loadSearchUsersUseCase: loadSearchUsersUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  // MARK: Private Methods
  private func getPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadPhotosUseCase {
    let loadPhotosRepository = LoadPhotosRepository(networkService: networkService)
    let requestController = RequestController()
    return LoadPhotosUseCase(
      repository: loadPhotosRepository,
      requestController: requestController
    )
  }
  
  private func getSearchPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadSearchPhotosUseCase {
    let loadPhotosRepository = LoadSearchPhotosRepository(networkService: networkService)
    let requestController = RequestController()
    return LoadSearchPhotosUseCase(
      repository: loadPhotosRepository,
      requestController: requestController
    )
  }
  
  private func getTopicsUseCase(
    _ networkService: NetworkService
  ) -> LoadTopicsUseCase {
    let loadTopicsRepository = LoadTopicsPageRepository(networkService: networkService)
    let requestController = RequestController()
    return LoadTopicsUseCase(
      repository: loadTopicsRepository,
      requestController: requestController
    )
  }
  
  private func getAlbumsUseCase(
    _ networkService: NetworkService
  ) -> LoadAlbumsUseCase {
    let loadAlbumsRepository = LoadAlbumsRepository(networkService: networkService)
    let requestController = RequestController()
    return LoadAlbumsUseCase(
      repository: loadAlbumsRepository,
      requestController: requestController
    )
  }
  
  private func getSearchAlbumsUseCase(
    _ networkService: NetworkService
  ) -> LoadSearchAlbumsUseCase {
    let loadAlbumsRepository = LoadSearchAlbumsRepository(networkService: networkService)
    let requestController = RequestController()
    return LoadSearchAlbumsUseCase(
      repository: loadAlbumsRepository,
      requestController: requestController
    )
  }
  
  private func getSearchUsersUseCase(
    _ networkService: NetworkService
  ) -> LoadSearchUsersUseCase {
    let loadUsersRepository = LoadSearchUsersRepository(networkService: networkService)
    let requestController = RequestController()
    return LoadSearchUsersUseCase(
      repository: loadUsersRepository,
      requestController: requestController
    )
  }
}
