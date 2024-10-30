//
//  SearchScreenViewModelProviderProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

/// Протокол определяет методы для создания различных
/// ViewModel-ов, используемых на экране поиска.
protocol SearchScreenViewModelProviderProtocol {
  
  /// Создает ViewModel для фотографий.
  ///
  /// - Returns: Экземпляр `DiscoverViewModel`,
  /// отвечающий за управление данными фотографий.
  func createPhotosViewModel() -> DiscoverViewModel
  
  /// Создает ViewModel для топиков.
  ///
  /// - Returns: Экземпляр `TopicsViewModel`,
  /// отвечающий за управление данными топиков.
  func createTopicsViewModel() -> TopicsViewModel
  
  /// Создает ViewModel для альбомов.
  ///
  /// - Returns: Экземпляр `AlbumsViewModel`,
  /// отвечающий за управление данными альбомов.
  func createAlbumsViewModel() -> AlbumsViewModel
  
  /// Создает ViewModel для пользователей.
  ///
  /// - Returns: Экземпляр `UsersViewModel`,
  /// отвечающий за управление данными пользователей.
  func createUsersViewModel() -> UsersViewModel
}

