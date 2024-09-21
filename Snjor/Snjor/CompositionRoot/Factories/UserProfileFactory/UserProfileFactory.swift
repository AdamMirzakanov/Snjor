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
  func makeController(
    delegate: any UserProfileViewControllerDelegate
  ) -> UIViewController {
    return getController(delegate: delegate)
  }
  
  func makePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = PhotoDetailFactory(photo: photo)
    return PhotoDetailCoordinator(
      factory: factory,
      navigation: navigation,
      parentCoordinator: parentCoordinator
    )
  }
  
  func makeAlbumPhotosCoordinator(
    album: Album,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = AlbumPhotosFactory(album: album)
    return AlbumPhotosCoordinator(
      factory: factory,
      navigation: navigation,
      parentCoordinator: parentCoordinator
    )
  }
  
  // MARK: Private Methods
  private func getController(delegate: any UserProfileViewControllerDelegate) -> UIViewController {
    let userProfileViewModel = viewModelProvider.createUserProfileViewModel(user: user)
    let userLakedPhotosViewModel = viewModelProvider.createUserLakedPhotosViewModel(user: user)
    let userPhotosViewModel = viewModelProvider.createUserPhotosViewModel(user: user)
    let userAlbumsViewModel = viewModelProvider.createUserAlbumsViewModel(user: user)
    return UserProfileViewController(
      userProfileViewModel: userProfileViewModel,
      userLikedPhotosViewModel: userLakedPhotosViewModel,
      userPhotosViewModel: userPhotosViewModel,
      userAlbumsViewModel: userAlbumsViewModel,
      delegate: delegate
    )
  }
}
