//
//  PrepareParameters.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

/// Перечисление `PrepareParameters`, содержащее методы и свойства
/// для подготовки параметров запросов к API Unsplash.
final class PrepareParameters {
  // MARK: Internal Properties
  /// Страница для получения фотографий. Начальное значение - 1.
  static var photosPage: Int = .page
  
  /// Страница для получения альбомов. Начальное значение - 1.
  static var albumsPage: Int = .page
  
  /// Страница для поиска фотографий. Начальное значение - 1.
  static var searchPhotosPage: Int = .page
  
  /// Страница для поиска альбомов. Начальное значение - 1.
  static var searchAlbumsPage: Int = .page
  
  /// Страница для поиска пользователей. Начальное значение - 1.
  static var searchUsersPage: Int = .page
  
  /// Страница для получения фотографий, понравившихся пользователю. Начальное значение - 1.
  static var userLikedPhotosPage: Int = .page
  
  /// Страница для получения фотографий пользователя. Начальное значение - 1.
  static var userPhotosPage: Int = .page
  
  /// Страница для получения альбомов пользователя. Начальное значение - 1.
  static var userAlbumsPage: Int = .page
  
  /// Менеджер для работы с хранилищем `UserDefaults`.
  let storage: any StorageManagerProtocol = StorageManager()
  
  // MARK: Internal  Methods
  /// Обновляет номер страницы для получения фотографий.
  func nextPhotosPage() {
    Self.photosPage += .page
  }
  
  /// Обновляет номер страницы для поиска фотографий.
  func nextSearchPhotosPage() {
    Self.searchPhotosPage += .page
  }
  
  /// Обновляет номер страницы для получения альбомов.
  func nextAlbumsPage() {
    Self.albumsPage += .page
  }
  
  /// Обновляет номер страницы для получения фотографий, понравившихся пользователю.
  func nextUserLikedPhotosPage() {
    Self.userLikedPhotosPage += .page
  }
  
  /// Обновляет номер страницы для получения фотографий пользователя.
  func nextUserPhotosPage() {
    Self.userPhotosPage += .page
  }
  
  /// Обновляет номер страницы для получения альбомов пользователя.
  func nextUserAlbumsPage() {
    Self.userAlbumsPage += .page
  }
  
  /// Обновляет номер страницы для поиска альбомов.
  func nextSearchAlbumsPage() {
    Self.searchAlbumsPage += .page
  }
  
  /// Обновляет номер страницы для поиска пользователей.
  func nextSearchUsersPage() {
    Self.searchUsersPage += .page
  }
}

// MARK: - Int
extension Int {
  /// Начальный номер страницы. Значение - 1.
  static var page = 1
  
  /// Количество элементов на странице. Значение - 30.
  static let perPage = 30
}
