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
  
  // MARK: Private Properties
  private let viewModelProvider: any UserProfileViewModelProviderProtocol
  
  // MARK: Initializers
  init(
    viewModelProvider: any UserProfileViewModelProviderProtocol = UserProfileViewModelProvider(),
    user: User
  ) {
    self.viewModelProvider = viewModelProvider
    self.user = user
  }
  
  // MARK: Internal Methods
  func makeController() -> UIViewController {
    return getController()
  }
  
  private func getController() -> UIViewController {
    let userProfileViewModel = viewModelProvider.createUserProfileViewModel(
      user: user
    )
    let userLakedPhotosViewModel = viewModelProvider.createUserLakedPhotosViewModel(
      user: user
    )
    let controller = UserProfileViewController(
      userProfileViewModel: userProfileViewModel,
      userLikedPhotosViewModel: userLakedPhotosViewModel
    )
    return controller
  }
}
