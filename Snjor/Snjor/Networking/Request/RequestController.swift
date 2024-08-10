//
//  RequestController.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

enum RequestController {
  // MARK: - Private Properties
  private static var photos: Endpoints { .photos }
  private static var topics: Endpoints { .topics }
  private static var searchPhotos: Endpoints { .searchPhotos }
  private static var collections: Endpoints { .collections }
  private static var searchCollections: Endpoints { .searchCollections }

  // MARK: - Internal Methods
  
  /// Список фотографий
  static func photoListRequest() throws -> URLRequest {
    let path = photos.rawValue
    let parameters = PrepareParameters.preparePhotoParameters()
    let request = try PrepareRequests.prepareAPIRequest(
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
    let request = try PrepareRequests.preparePhotoInfoAPIRequest(path: path, id: id)
    return request
  }
  
  /// Фотографии внутри категории
  static func topicsPhotoListRequest(topic: Topic) throws -> URLRequest {
    let topicsPath = topics.rawValue
    let id = topic.id
    let photosPath = photos.rawValue
    let parameters = PrepareParameters.preparePhotoParameters()
    let request = try PrepareRequests.prepareTopicsPhotosAPIRequest(
      topics: topicsPath,
      id: id,
      phtos: photosPath,
      parameters: parameters
    )
    return request
  }
  
  /// Категория
  static func topicsTitleRequest() throws -> URLRequest {
    let topicsPath = topics.rawValue
    let request = try PrepareRequests.prepareTopicsTitleAPIRequest(topics: topicsPath)
    return request
  }
  
  /// Альбомы
  static func albumListRequest() throws -> URLRequest {
    let path = collections.rawValue
    let parameters = PrepareParameters.prepareAlbumParameters()
    let request = try PrepareRequests.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    print(request)
    return request
  }
}
