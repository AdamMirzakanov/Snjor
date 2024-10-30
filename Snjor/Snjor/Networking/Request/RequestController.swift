//
//  RequestController.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// `RequestController` управляет формированием запросов к API для получения
/// различных данных, таких как фотографии, альбомы, пользователи топики и т.д.
enum RequestController {
  // MARK: Private Properties
  private static var photos: Endpoints { .photos }
  private static var topics: Endpoints { .topics }
  private static var searchPhotos: Endpoints { .searchPhotos }
  private static var albums: Endpoints { .collections }
  private static var searchCollections: Endpoints { .searchCollections }
  private static var searchUsers: Endpoints { .searchUsers }
  private static var userProfile: Endpoints { .userProfile }

  // MARK: - Internal Methods
  /// Формирует запрос для получения фотографий.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использован для выполнения
  /// запроса к API для получения списка фотографий. Он использует заранее подготовленные
  /// параметры запроса, специфичные для фотографий.
  ///
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для получения фотографий.
  /// - Note: Метод использует вспомогательный класс `PrepareParameters`
  /// для подготовки параметров запроса и `PrepareRequest` для формирования самого запроса.
  static func photosRequest() throws -> URLRequest {
    let path = photos.rawValue
    let parameters = PrepareParameters.preparePhotosParameters()
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для получения альбомов.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использован для выполнения
  /// запроса к API для получения списка альбомов. Он использует заранее подготовленные
  /// параметры запроса, специфичные для альбомов.
  ///
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение альбомов.
  static func albumsRequest() throws -> URLRequest {
    let path = albums.rawValue
    let parameters = PrepareParameters.prepareAlbumParameters()
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для поиска фотографий.
  ///
  /// Этот метод использует переданный строковый параметр `searchTerm` для подготовки
  /// параметров запроса, а затем создает объект `URLRequest`, который будет использован
  /// для выполнения запроса к API для получения фотографий, соответствующих указанному
  /// в стороке поиска.
  ///
  /// - Parameter searchTerm: Строка, представляющая текст поиска для фотографий.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на поиск фотографий.
  static func searchPhotosRequest(with searchTerm: String) throws -> URLRequest {
    let path = searchPhotos.rawValue
    let parameters = PrepareParameters.prepareSearchPhotoParameters(with: searchTerm)
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для поиска альбомов.
  ///
  /// Этот метод использует переданный строковый параметр `searchTerm` для подготовки
  /// параметров запроса, а затем создает объект `URLRequest`, который будет использован
  /// для выполнения запроса к API для получения альбомов, соответствующих указанному
  /// в стороке поиска.
  ///
  /// - Parameter searchTerm: Строка, представляющая текст поиска для альбомов.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на поиск альбомов.
  static func searchAlbumsRequest(with searchTerm: String) throws -> URLRequest {
    let path = searchCollections.rawValue
    let parameters = PrepareParameters.prepareSearchAlbumsParameters(with: searchTerm)
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для поиска пользователей.
  ///
  /// Этот метод использует переданный строковый параметр `searchTerm` для подготовки
  /// параметров запроса, а затем создает объект `URLRequest`, который будет использован
  /// для выполнения запроса к API для получения пользователей, соответствующих указанному
  /// в стороке поиска.
  ///
  /// - Parameter searchTerm: Строка, представляющая текст поиска для пользователей.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на поиск пользователей.
  static func searchUsersRequest(with searchTerm: String) throws -> URLRequest {
    let path = searchUsers.rawValue
    let parameters = PrepareParameters.prepareSearchUsersParameters(with: searchTerm)
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }

  /// Формирует запрос для получения детальной информации о фотографии.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использоваться для выполнения
  /// запроса к API для получения полной информации о конкретной фотографии. Запрос
  /// включает идентификатор фотографии в качестве сегмента пути.
  ///
  /// - Parameter photo: Объект `Photo`, представляющий фотографию, для которой нужно
  /// получить информацию.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение
  /// детальной информации о фотографии.
  /// - Note: Сюда нужно совершить отдельный запрос так как фотография получаемая
  ///   в ячейке содержит ограниченную информацию о фотографии.
  static func photoDetailRequest(photo: Photo) throws -> URLRequest {
    let path = photos.rawValue
    let id = photo.id
    let request = try PrepareRequest.preparePhotoInfoAPIRequest(    path: path, idPathSegment: id)
    return request
  }
  
  /// Формирует запрос для получения информации о профиле пользователя.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использоваться для выполнения
  /// запроса к API для получения данных о конкретном пользователе. Запрос включает
  /// имя пользователя в качестве сегмента пути.
  ///
  /// - Parameter user: Объект `User`, представляющий пользователя, информацию о профиле
  /// которого нужно получить.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение
  /// информации о профиле пользователя.
  static func userProfileRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let request = try PrepareRequest.prepareUserProfileAPIRequest(
      path: path,
      usernamePathSegment: username
    )
    return request
  }
  
  /// Формирует запрос для получения фотографий, которые пользователь лайкал.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использоваться для выполнения
  /// запроса к API для получения всех фотографий, которые были лайкнуты конкретным пользователем.
  /// Запрос включает имя пользователя в качестве сегмента пути и параметры, необходимые для
  /// корректного формирования запроса.
  ///
  /// - Parameter user: Объект `User`, представляющий пользователя, чьи лайкнутые фотографии
  /// нужно получить.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение
  /// лайкнутых фотографий пользователя.
  static func userLikedPhotosRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareUserLikedPhotosParameters()
    let request = try PrepareRequest.prepareUserLikedPhotosAPIRequest(
      path: path,
      usernamePathSegment: username, 
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для получения фотографий, принадлежащих пользователю.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использоваться для выполнения
  /// запроса к API для получения всех фотографий, загруженных конкретным пользователем.
  /// Запрос включает имя пользователя в качестве сегмента пути и параметры, необходимые для
  /// корректного формирования запроса.
  ///
  /// - Parameter user: Объект `User`, представляющий пользователя, чьи фотографии
  /// нужно получить.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение
  /// фотографий пользователя.
  static func userPhotosRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareUserPhotosParameters()
    let request = try PrepareRequest.prepareUserPhotosAPIRequest(
      path: path,
      usernamePathSegment: username,
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для получения альбомов, принадлежащих пользователю.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использоваться для выполнения
  /// запроса к API для получения всех альбомов, созданных конкретным пользователем.
  /// Запрос включает имя пользователя в качестве сегмента пути и необходимые параметры
  /// для корректного формирования запроса.
  ///
  /// - Parameter user: Объект `User`, представляющий пользователя, чьи альбомы
  /// нужно получить.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение
  /// альбомов пользователя.
  static func userAlbumsRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareUserAlbumsParameters()
    let request = try PrepareRequest.prepareUserAlbumsAPIRequest(
      path: path,
      usernamePathSegment: username,
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для получения случайной фотографии пользователя.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использоваться для выполнения
  /// запроса к API для получения случайной фотографии, связанной с конкретным пользователем.
  /// Запрос включает имя пользователя в параметрах и путь к фотографиям.
  ///
  /// - Parameter user: Объект `User`, представляющий пользователя, для которого
  /// нужно получить случайную фотографию.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение
  /// случайной фотографии пользователя.
  /// - Note: Запрашиается вертикальная фотография.
  static func randomUserPhotoRequest(user: User) throws -> URLRequest {
    let path = photos.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareRandomUserPhotoParameters(username: username)
    let request = try PrepareRequest.prepareRandomUserPhotoAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для получения фотографий внутри определенного топика.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использоваться для выполнения
  /// запроса к API для получения фотографий, относящихся к конкретной категории (топика).
  /// Запрос включает идентификатор топика и путь к фотографиям, а также параметры
  /// для фильтрации результатов.
  ///
  /// - Parameter topic: Объект `Topic`, представляющий категорию, для которой
  /// нужно получить фотографии.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение
  /// фотографий по заданному топику.
  static func topicPhotosRequest(topic: Topic) throws -> URLRequest {
    let topicsPath = topics.rawValue
    let id = topic.id
    let photosPath = photos.rawValue
    let parameters = PrepareParameters.preparePhotosParameters()
    let request = try PrepareRequest.prepareTopicPhotosAPIRequest(
          path: topicsPath,
      idPathSegment: id,
      photosPathSegment: photosPath,
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для получения фотографий внутри определенного альбома.
  ///
  /// Этот метод создает объект `URLRequest`, который будет использоваться для выполнения
  /// запроса к API с целью получения фотографий, относящихся к заданному альбому.
  /// Запрос включает идентификатор альбома, путь к альбомам и фотографии, а также
  /// параметры для фильтрации результатов.
  ///
  /// - Parameter album: Объект `Album`, представляющий альбом, для которого
  /// нужно получить фотографии.
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение
  /// фотографий внутри указанного альбома.
  static func albumPhotosRequest(album: Album) throws -> URLRequest {
    let albumsPath = albums.rawValue
    let id = album.id
    let photosPath = photos.rawValue
    let parameters = PrepareParameters.preparePhotosParameters()
    let request = try PrepareRequest.prepareAlbumPhotosAPIRequest(
          path: albumsPath,
      idPathSegment: id,
      phtosPathSegment: photosPath,
      parameters: parameters
    )
    return request
  }
  
  /// Формирует запрос для получения заголовков категорий (топиков).
  ///
  /// Этот метод создает объект `URLRequest`, который будет использоваться для выполнения
  /// запроса к API с целью получения списка заголовков доступных топиков.
  ///
  /// - Throws: `APIError` в случае ошибки при подготовке запроса.
  /// - Returns: Настроенный объект `URLRequest` для выполнения запроса на получение
  /// заголовков топиков.
  static func topicsTitleRequest() throws -> URLRequest {
    let topicsPath = topics.rawValue
    let request = try PrepareRequest.prepareTopicsTitleAPIRequest(    path: topicsPath)
    return request
  }
}
