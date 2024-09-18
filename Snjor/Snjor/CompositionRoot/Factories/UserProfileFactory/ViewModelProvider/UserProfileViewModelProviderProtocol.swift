//
//  UserProfileViewModelProviderProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.09.2024.
//

protocol UserProfileViewModelProviderProtocol {
  func createUserProfileViewModel(user: User) -> UserProfileViewModel
  func createUserLakedPhotosViewModel(user: User) -> UserLakedPhotosViewModel
  func createUserPhotosViewModel(user: User) -> UserPhotosViewModel
  func createUserAlbumsViewModel(user: User) -> UserAlbumsViewModel
}
