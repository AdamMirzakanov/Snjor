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
  private static var searchPhotos: Endpoints { .searchPhotos }
  private static var collections: Endpoints { .collections }
  private static var searchCollections: Endpoints { .searchCollections }

  // MARK: - Public Methods
  static func photosURLRequest() throws -> URLRequest {
    let path = photos.rawValue
    let parameters = PrepareParameters.preparePhotoParameters()
    let request = try PrepareRequests.prepareURLRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
}