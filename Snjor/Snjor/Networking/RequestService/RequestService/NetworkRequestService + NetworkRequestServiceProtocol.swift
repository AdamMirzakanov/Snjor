//
//  NetworkRequestService + NetworkRequestServiceProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import Foundation

fileprivate typealias Const = PrepareRequestConst

extension NetworkRequestService: NetworkRequestServiceProtocol {
  
  func prepareAPIRequest(
    path: String,
    parameters: Parameters? = nil,
    additionalPathComponents: [String] = []
  ) throws -> URLRequest {
    guard let baseURL = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    
    let finalURL = additionalPathComponents.reduce(baseURL) { url, component in
      url.appending(path: component)
    }
    return prepareURLRequest(url: finalURL)
  }
  
  func prepareTopicsTitleAPIRequest(path: String) throws -> URLRequest {
    try prepareAPIRequest(path: path)
  }
  
  func prepareTopicPhotosAPIRequest(
    path: String,
    idPathSegment: String,
    photosPathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    try prepareAPIRequest(
      path: path,
      parameters: parameters,
      additionalPathComponents: [idPathSegment, photosPathSegment]
    )
  }
  
  func prepareAlbumPhotosAPIRequest(
    path: String,
    idPathSegment: String,
    phtosPathSegment photosPathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    try prepareAPIRequest(
      path: path,
      parameters: parameters,
      additionalPathComponents: [idPathSegment, photosPathSegment]
    )
  }
  
  func preparePhotoInfoAPIRequest(
    path: String,
    idPathSegment: String
  ) throws -> URLRequest {
    try prepareAPIRequest(
      path: path,
      additionalPathComponents: [idPathSegment]
    )
  }
  
  func prepareUserProfileAPIRequest(
    path: String,
    usernamePathSegment: String
  ) throws -> URLRequest {
    try prepareAPIRequest(
      path: path,
      additionalPathComponents: [usernamePathSegment]
    )
  }
  
  func prepareUserLikedPhotosAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    try prepareAPIRequest(
      path: path,
      parameters: parameters,
      additionalPathComponents: [usernamePathSegment, Const.likesPathComponent]
    )
  }
  
  func prepareRandomUserPhotoAPIRequest(
    path: String,
    parameters: Parameters
  ) throws -> URLRequest {
    try prepareAPIRequest(
      path: path,
      parameters: parameters,
      additionalPathComponents: [Const.randomPathComponent]
    )
  }
  
  func prepareUserPhotosAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    try prepareAPIRequest(
      path: path,
      parameters: parameters,
      additionalPathComponents: [usernamePathSegment, Const.photosPathComponent]
    )
  }
  
  func prepareUserAlbumsAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    try prepareAPIRequest(
      path: path,
      parameters: parameters,
      additionalPathComponents: [usernamePathSegment, Const.collectionsPathComponent]
    )
  }
}
