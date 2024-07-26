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
  static func photoListRequest() throws -> URLRequest {
    let path = photos.rawValue
    let parameters = PrepareParameters.preparePhotoParameters()
    let request = try PrepareRequests.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }

  static func photoDetailRequest(photo: Photo) throws -> URLRequest {
    let path = photos.rawValue
    let id = photo.id
    let request = try PrepareRequests.preparePhotoInfoAPIRequest(path: path, id: id)
    return request
  }
  
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
  
  static func topicsTitleRequest() throws -> URLRequest {
    let topicsPath = topics.rawValue
    let request = try PrepareRequests.prepareTopicsTitleAPIRequest(topics: topicsPath)
    return request
  }
}
