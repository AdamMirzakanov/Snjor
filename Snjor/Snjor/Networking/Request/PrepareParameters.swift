//
//  PrepareParameters.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// Перечисление `PrepareParameters`, содержащее методы и свойства
/// для подготовки параметров запросов к API Unsplash.
enum PrepareParameters {
  
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
  
  // MARK: Private  Properties
  /// Менеджер для работы с хранилищем `UserDefaults`.
  private static let storage: any StorageManagerProtocol = StorageManager()
  
  // MARK: Internal Methods
  /// Подготавливает параметры для получения фотографий.
  /// - Returns: Словарь с параметрами запроса, включая:
  /// номер страницы и количество элементов на странице.
  static func preparePhotosParameters() -> Parameters {
    nextPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(photosPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
  
  /// Подготавливает параметры для получения альбомов.
  /// - Returns: Словарь с параметрами запроса, включая:
  /// номер страницы и количество элементов на странице.
  static func prepareAlbumParameters() -> Parameters {
    nextAlbumsPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(albumsPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
  
  /// Подготавливает параметры для получения фотографий, понравившихся пользователю.
  /// - Returns: Словарь с параметрами запроса, включая:
  /// номер страницы и количество элементов на странице.
  static func prepareUserLikedPhotosParameters() -> Parameters {
    nextUserLikedPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(userLikedPhotosPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
  
  /// Подготавливает параметры для получения фотографий пользователя.
  /// - Returns: Словарь с параметрами запроса, включая:
  /// номер страницы и количество элементов на странице.
  static func prepareUserPhotosParameters() -> Parameters {
    nextUserPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(userPhotosPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
  
  /// Подготавливает параметры для получения случайной фотографии пользователя по имени.
  /// - Parameter username: Имя пользователя, для которого запрашивается фотография.
  /// - Returns: Словарь с параметрами запроса, включая:
  /// имя пользователя и ориентацию.
  static func prepareRandomUserPhotoParameters(username: String) -> Parameters {
    var parameters: Parameters = [:]
    parameters[ParamKey.username.rawValue] = username
    parameters[ParamKey.orientation.rawValue] = ParamValue.portrait.rawValue
    return parameters
  }
  
  /// Подготавливает параметры для получения альбомов пользователя.
  /// - Returns: Словарь с параметрами запроса, включая:
  /// номер страницы и количество элементов на странице.
  static func prepareUserAlbumsParameters() -> Parameters {
    nextUserAlbumsPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(userAlbumsPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
  
  /// Подготавливает параметры для поиска фотографий по заданному запросу.
  /// - Parameter searchTerm: Поисковый запрос для поиска фотографий.
  /// - Returns: Словарь с параметрами запроса, включая:
  /// поисковый запрос,
  /// номер страницы,
  /// ориентацию искомых фотографий,
  /// фильтрацию по релевантности,
  /// а так-же по цвету если они заданы.
  static func prepareSearchPhotoParameters(with searchTerm: String) -> Parameters {
    nextSearchPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.query.rawValue] = searchTerm
    parameters[ParamKey.page.rawValue] = String(searchPhotosPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    
    if let orientation = storage.string(forKey: .photoOrientationKey) {
      parameters[ParamKey.orientation.rawValue] = orientation
    }
    
    if let contentFilter = storage.string(forKey: .sortingPhotosKey) {
      parameters[ParamKey.orderBy.rawValue] = contentFilter
    }
    
    if let color = storage.string(forKey: .selectedCircleButtonKey) {
      switch color {
      case ParamValue.blackAndWhite.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.green.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.yellow.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.orange.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.red.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.purple.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.blue.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.teal.rawValue:
        parameters[ParamKey.color.rawValue] = color
      default:
        storage.remove(forKey: .selectedCircleButtonKey)
      }
    }
    return parameters
  }
  
  /// Подготавливает параметры для поиска альбомов по заданному запросу.
  /// - Parameter searchTerm: Поисковый запрос для поиска альбомов.
  /// - Returns: Словарь с параметрами запроса, включая:
  /// поисковый запрос, номер страницы и количество элементов на странице.
  static func prepareSearchAlbumsParameters(with searchTerm: String) -> Parameters {
    nextSearchAlbumsPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.query.rawValue] = searchTerm
    parameters[ParamKey.page.rawValue] = String(searchAlbumsPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
  
  /// Подготавливает параметры для поиска пользователей по заданному запросу.
  /// - Parameter searchTerm: Поисковый запрос для поиска пользователей.
  /// - Returns: Словарь с параметрами запроса, включая:
  /// поисковый запрос, номер страницы и количество элементов на странице.
  static func prepareSearchUsersParameters(with searchTerm: String) -> Parameters {
    nextSearchUsersPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.query.rawValue] = searchTerm
    parameters[ParamKey.page.rawValue] = String(searchUsersPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
  
  // MARK: Private  Methods
  /// Обновляет номер страницы для получения фотографий.
  private static func nextPhotosPage() {
    photosPage += .page
  }
  
  /// Обновляет номер страницы для поиска фотографий.
  private static func nextSearchPhotosPage() {
    searchPhotosPage += .page
  }
  
  /// Обновляет номер страницы для получения альбомов.
  private static func nextAlbumsPage() {
    albumsPage += .page
  }
  
  /// Обновляет номер страницы для получения фотографий, понравившихся пользователю.
  private static func nextUserLikedPhotosPage() {
    userLikedPhotosPage += .page
  }
  
  /// Обновляет номер страницы для получения фотографий пользователя.
  private static func nextUserPhotosPage() {
    userPhotosPage += .page
  }
  
  /// Обновляет номер страницы для получения альбомов пользователя.
  private static func nextUserAlbumsPage() {
    userAlbumsPage += .page
  }
  
  /// Обновляет номер страницы для поиска альбомов.
  private static func nextSearchAlbumsPage() {
    searchAlbumsPage += .page
  }
  
  /// Обновляет номер страницы для поиска пользователей.
  private static func nextSearchUsersPage() {
    searchUsersPage += .page
  }
}

// MARK: - Int
private extension Int {

  /// Начальный номер страницы. Значение - 1.
  static var page = 1
  
  /// Количество элементов на странице. Значение - 30.
  static let perPage = 30
}
