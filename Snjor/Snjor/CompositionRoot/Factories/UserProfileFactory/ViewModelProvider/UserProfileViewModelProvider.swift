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
    return UserProfileViewModel(
      state: state,
      loadUseCase: loadUserProfileUseCase
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
}
