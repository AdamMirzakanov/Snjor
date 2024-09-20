//
//  UserProfileViewModelProvider.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.09.2024.
//

import Combine

final class UserProfileViewModelProvider: UserProfileViewModelProviderProtocol {
  // MARK: Private Properties
  private let networkService = NetworkService()
  private let lastPageValidationUseCase = LastPageValidationUseCase()
  private let state = PassthroughSubject<StateController, Never>()
  
  // MARK: Internal Methods
  func createUserProfileViewModel(user: User) -> UserProfileViewModel {
    let loadUserProfileUseCase = getUserProfileUseCase(
      networkService,
      user: user
    )
    let loadRandomPhotoUseCase = getRandomPhotoUseCase(
      networkService,
      user: user
    )
    return UserProfileViewModel(
      state: state,
      loadUseCase: loadUserProfileUseCase,
      loadRandomPhotoUseCase: loadRandomPhotoUseCase
    )
  }
  
  func createUserLakedPhotosViewModel(user: User) -> UserLakedPhotosViewModel {
    let loadUserLakedPhotosUseCase = getUserLakedPhotosUseCase(
      networkService,
      user: user
    )
    return UserLakedPhotosViewModel(
      loadUseCase: loadUserLakedPhotosUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  func createUserPhotosViewModel(user: User) -> UserPhotosViewModel {
    let loadUserPhotosUseCase = getUserPhotosUseCase(
      networkService,
      user: user
    )
    return UserPhotosViewModel(
      loadUseCase: loadUserPhotosUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  func createUserAlbumsViewModel(user: User) -> UserAlbumsViewModel {
    let loadUserAlbumsUseCase = getUserAlbumsUseCase(
      networkService,
      user: user
    )
    return UserAlbumsViewModel(
      loadUseCase: loadUserAlbumsUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  // MARK: Private Methods
  private func getUserProfileUseCase(
    _ networkService: NetworkService,
    user: User
  ) -> LoadUserProfileUseCase {
    let loadUserProfileRepository = LoadUserProfileRepository(
      networkService: networkService
    )
    return LoadUserProfileUseCase(
      repository: loadUserProfileRepository,
      user: user
    )
  }
  
  private func getRandomPhotoUseCase(
    _ networkService: NetworkService,
    user: User
  ) -> LoadRandomUserPhotoUseCase {
    let loadRandomUserPhotoRepository = LoadRandomUserPhotoRepository(
      networkService: networkService
    )
    return LoadRandomUserPhotoUseCase(
      repository: loadRandomUserPhotoRepository,
      user: user
    )
  }
  
  private func getUserLakedPhotosUseCase(
    _ networkService: NetworkService,
    user: User
  ) -> LoadUserLikedPhotosUseCase {
    let loadUserLakedPhotosRepository = LoadUserLikedPhotosRepository(
      networkService: networkService
    )
    return LoadUserLikedPhotosUseCase(
      repository: loadUserLakedPhotosRepository,
      user: user
    )
  }
  
  private func getUserPhotosUseCase(
    _ networkService: NetworkService,
    user: User
  ) -> LoadUserPhotosUseCase {
    let loadUserPhotosRepository = LoadUserPhotosRepository(
      networkService: networkService
    )
    return LoadUserPhotosUseCase(
      repository: loadUserPhotosRepository,
      user: user
    )
  }
  
  private func getUserAlbumsUseCase(
    _ networkService: NetworkService,
    user: User
  ) -> LoadUserAlbumsUseCase {
    let loadUserAlbumsRepository = LoadUserAlbumsRepository(
      networkService: networkService
    )
    return LoadUserAlbumsUseCase(
      repository: loadUserAlbumsRepository,
      user: user
    )
  }
}
