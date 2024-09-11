//
//  UserProfileFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

import UIKit
import Combine

struct UserProfileFactory: UserProfileFactoryProtocol {
  // MARK: Internal Properties
  let user: User
  
  // MARK: Internal Methods
  func makeController() -> UIViewController {
    let state = PassthroughSubject<StateController, Never>()
    let networkService = NetworkService()
    let repository = LoadUserProfileRepository(
      networkService: networkService
    )
    let loadUseCase = LoadUserProfileUseCase(
      repository: repository,
      user: user
    )
    let viewModel = UserProfileViewModel(
      state: state,
      loadUseCase: loadUseCase
    )
    return UserProfileViewController(viewModel: viewModel)
  }
}
