//
//  UserProfileViewModelProviderProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.09.2024.
//

/// Протокол определяет методы для создания различных ViewModel-ов,
/// связанных с профилем пользователя.
protocol UserProfileViewModelProviderProtocol {
  
  /// Создает ViewModel для профиля пользователя.
  ///
  /// - Parameter user: Экземпляр `User`, представляющий пользователя.
  /// - Returns: Экземпляр `UserProfileViewModel`,
  /// отвечающий за управление данными профиля пользователя.
  func createUserProfileViewModel(user: User) -> UserProfileViewModel
  
  /// Создает ViewModel для лайкнутых фотографий пользователя.
  ///
  /// - Parameter user: Экземпляр `User`, представляющий пользователя.
  /// - Returns: Экземпляр `UserLakedPhotosViewModel`,
  /// отвечающий за управление данными лайкнутых фотографий пользователя.
  func createUserLakedPhotosViewModel(user: User) -> UserLakedPhotosViewModel
  
  /// Создает ViewModel для фотографий пользователя.
  ///
  /// - Parameter user: Экземпляр `User`, представляющий пользователя.
  /// - Returns: Экземпляр `UserPhotosViewModel`,
  /// отвечающий за управление данными фотографий пользователя.
  func createUserPhotosViewModel(user: User) -> UserPhotosViewModel
  
  /// Создает ViewModel для альбомов пользователя.
  ///
  /// - Parameter user: Экземпляр `User`, представляющий пользователя.
  /// - Returns: Экземпляр `UserAlbumsViewModel`,
  /// отвечающий за управление данными альбомов пользователя.
  func createUserAlbumsViewModel(user: User) -> UserAlbumsViewModel
}
