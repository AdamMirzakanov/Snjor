//
//  RequestController.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

enum RequestController {
  // MARK: - Private Properties
  private static var photoListEndpoint: Endpoints { .photos }
  private static var photoEndpoint: Endpoints { .photo }
  private static var searchPhotosEndpoint: Endpoints { .searchPhotos }
  private static var collectionsEndpoint: Endpoints { .collections }
  private static var searchCollectionsEndpoint: Endpoints { .searchCollections }

  // MARK: - Internal Methods
  static func photoListRequest() throws -> URLRequest {
    let path = photoListEndpoint.rawValue
    let parameters = PrepareParameters.preparePhotoParameters()
    let request = try PrepareRequests.prepareURLRequest(
      path: path,
      parameters: parameters
    )
    return request
  }

  static func photoRequest(photo: Photo) throws -> URLRequest {
    let path = photoEndpoint.rawValue
    let id = photo.id
    let request = try PrepareRequests.prepareInfoURLRequest(path: path, id: id)
    return request
  }
}
