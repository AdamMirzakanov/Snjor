//
//  RequestController.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

enum RequestController {
  // MARK: Private Properties
  private static var photos: Endpoints { .photos }
  private static var topics: Endpoints { .topics }
  private static var searchPhotos: Endpoints { .searchPhotos }
  private static var albums: Endpoints { .collections }
  private static var searchCollections: Endpoints { .searchCollections }
  private static var searchUsers: Endpoints { .searchUsers }
  private static var userProfile: Endpoints { .userProfile }

  // MARK: Internal Methods
  /// Список фотографий
  static func photosRequest() throws -> URLRequest {
    let path = photos.rawValue
    let parameters = PrepareParameters.preparePhotosParameters()
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  static func searchPhotosRequest(with searchTerm: String) throws -> URLRequest {
    let path = searchPhotos.rawValue
    let parameters = PrepareParameters.prepareSearchPhotoParameters(with: searchTerm)
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  static func searchAlbumsRequest(with searchTerm: String) throws -> URLRequest {
    let path = searchCollections.rawValue
    let parameters = PrepareParameters.prepareSearchAlbumsParameters(with: searchTerm)
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  static func searchUsersRequest(with searchTerm: String) throws -> URLRequest {
    let path = searchUsers.rawValue
    let parameters = PrepareParameters.prepareSearchUsersParameters(with: searchTerm)
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }

  /// Информация о фотографии
  ///
  /// Сюда нужно совершить отдельный запрос, так как
  /// информация о фотографии получаемая со списком фотографий ограничена,
  /// данный запрос содержит и саму фотографию и полный набор информации
  /// предоставляемый хостингом
  static func photoDetailRequest(photo: Photo) throws -> URLRequest {
    let path = photos.rawValue
    let id = photo.id
    let request = try PrepareRequest.preparePhotoInfoAPIRequest(path: path, id: id)
    return request
  }
  
  static func userProfileRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let request = try PrepareRequest.prepareUserProfileAPIRequest(
      path: path,
      username: username
    )
    return request
  }
  
  /// Фотографии которые лайкал пользователь
  static func userLikedPhotosRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareUserLikedPhotosParameters()
    let request = try PrepareRequest.prepareUserLikedPhotosAPIRequest(
      path: path,
      username: username, 
      parameters: parameters
    )
    return request
  }
  
  /// Фотографии которые принадлежат пользователю
  static func userPhotosRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareUserPhotosParameters()
    let request = try PrepareRequest.prepareUserPhotosAPIRequest(
      path: path,
      username: username,
      parameters: parameters
    )
    return request
  }
  
  /// Альбомы которые принадлежат пользователю
  static func userAlbumsRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareUserAlbumsParameters()
    let request = try PrepareRequest.prepareUserAlbumsAPIRequest(
      path: path,
      username: username,
      parameters: parameters
    )
    return request
  }
  
  /// Фотографии внутри категории
  static func topicPhotosRequest(topic: Topic) throws -> URLRequest {
    let topicsPath = topics.rawValue
    let id = topic.id
    let photosPath = photos.rawValue
    let parameters = PrepareParameters.preparePhotosParameters()
    let request = try PrepareRequest.prepareTopicPhotosAPIRequest(
      topics: topicsPath,
      id: id,
      phtos: photosPath,
      parameters: parameters
    )
    return request
  }
  
  /// Фотографии внутри альбомов
  static func albumPhotosRequest(album: Album) throws -> URLRequest {
    let albumsPath = albums.rawValue
    let id = album.id
    let photosPath = photos.rawValue
    let parameters = PrepareParameters.preparePhotosParameters()
    let request = try PrepareRequest.prepareAlbumPhotosAPIRequest(
      albums: albumsPath,
      id: id,
      phtos: photosPath,
      parameters: parameters
    )
    return request
  }
  
  /// Категория
  static func topicsTitleRequest() throws -> URLRequest {
    let topicsPath = topics.rawValue
    let request = try PrepareRequest.prepareTopicsTitleAPIRequest(topics: topicsPath)
    return request
  }
  
  /// Альбомы
  static func albumsRequest() throws -> URLRequest {
    let path = albums.rawValue
    let parameters = PrepareParameters.prepareAlbumParameters()
    let request = try PrepareRequest.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
}
