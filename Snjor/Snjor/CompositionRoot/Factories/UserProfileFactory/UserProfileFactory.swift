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
  private let layoutProvider: LayoutProvider
  
  // MARK: Initializers
  init(
    viewModelProvider: any UserProfileViewModelProviderProtocol = UserProfileViewModelProvider(),
    layoutProvider: LayoutProvider = LayoutProvider(),
    user: User
  ) {
    self.viewModelProvider = viewModelProvider
    self.layoutProvider = layoutProvider
    self.user = user
  }
  
  // MARK: Internal Methods
  func makeController() -> UIViewController {
    return getController()
  }
  
  // MARK: Private Methods
  private func getController() -> UIViewController {
    let userProfileViewModel = viewModelProvider.createUserProfileViewModel(
      user: user
    )
    let userLakedPhotosViewModel = viewModelProvider.createUserLakedPhotosViewModel(
      user: user
    )
    
    let userPhotosViewModel = viewModelProvider.createUserPhotosViewModel(
      user: user
    )
    
    let controller = UserProfileViewController(
      userProfileViewModel: userProfileViewModel,
      userLikedPhotosViewModel: userLakedPhotosViewModel,
      userPhotosViewModel: userPhotosViewModel
    )
    return controller
  }
}
