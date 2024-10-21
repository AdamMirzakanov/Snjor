//
//  PrepareParameters.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

enum PrepareParameters {
  // MARK: Internal Properties
  static var photosPage: Int = .page
  static var albumsPage: Int = .page
  static var searchPhotosPage: Int = .page
  static var searchAlbumsPage: Int = .page
  static var searchUsersPage: Int = .page
  static var userLikedPhotosPage: Int = .page
  static var userPhotosPage: Int = .page
  static var userAlbumsPage: Int = .page
  
  // MARK: Private  Properties
  private static let perPage: Int = .perPage
  private static   let storage: any StorageManagerProtocol = StorageManager()
  
  // MARK: Internal Methods
  static func preparePhotosParameters() -> Parameters {
    nextPhotosPage()
    var parameters: Parameters = [:]
    parameters[.page] = String(photosPage)
    parameters[.perPage] = String(perPage)
    return parameters
  }
  
  static func prepareAlbumParameters() -> Parameters {
    nextAlbumsPage()
    var parameters: Parameters = [:]
    parameters[.page] = String(albumsPage)
    parameters[.perPage] = String(perPage)
    return parameters
  }
  
  static func prepareUserLikedPhotosParameters() -> Parameters {
    nextUserLikedPhotosPage()
    var parameters: Parameters = [:]
    parameters[.page] = String(userLikedPhotosPage)
    parameters[.perPage] = String(perPage)
    return parameters
  }
  
  static func prepareUserPhotosParameters() -> Parameters {
    nextUserPhotosPage()
    var parameters: Parameters = [:]
    parameters[.page] = String(userPhotosPage)
    parameters[.perPage] = String(perPage)
    return parameters
  }
  
  static func prepareRandomUserPhotoParameters(username: String) -> Parameters {
    var parameters: Parameters = [:]
    parameters[.username] = username
    parameters[.orientation] = .portrait
    return parameters
  }
  
  static func prepareUserAlbumsParameters() -> Parameters {
    nextUserAlbumsPage()
    var parameters: Parameters = [:]
    parameters[.page] = String(userAlbumsPage)
    parameters[.perPage] = String(perPage)
    return parameters
  }

  static func prepareSearchPhotoParameters(with searchTerm: String) -> Parameters {
    nextSearchPhotosPage()
    var parameters: Parameters = [:]
    parameters[.query] = searchTerm
    parameters[.page] = String(searchPhotosPage)
    parameters[.perPage] = String(perPage)
    
    if let orientation = storage.string(forKey: .photoOrientationKey) {
      parameters[.orientation] = orientation
    }
    if let contentFilter = storage.string(forKey: .contentFilterKey) {
      parameters[.contentFilter] = contentFilter
    }
    if let contentFilter = storage.string(forKey: .sortingPhotosKey) {
      parameters[.orderBy] = contentFilter
    }
    return parameters
  }
  
  static func prepareSearchAlbumsParameters(with searchTerm: String) -> Parameters {
    nextSearchAlbumsPage()
    var parameters: Parameters = [:]
    parameters[.query] = searchTerm
    parameters[.page] = String(searchAlbumsPage)
    parameters[.perPage] = String(perPage)
    return parameters
  }
  
  static func prepareSearchUsersParameters(with searchTerm: String) -> Parameters {
    nextSearchUsersPage()
    var parameters: Parameters = [:]
    parameters[.query] = searchTerm
    parameters[.page] = String(searchUsersPage)
    parameters[.perPage] = String(perPage)
    return parameters
  }
  
  // MARK: Private  Methods
  private static func nextPhotosPage() {
    photosPage += .page
  }
  
  private static func nextSearchPhotosPage() {
    searchPhotosPage += .page
  }
  
  private static func nextAlbumsPage() {
    albumsPage += .page
  }
  
  private static func nextUserLikedPhotosPage() {
    userLikedPhotosPage += .page
  }
  
  private static func nextUserPhotosPage() {
    userPhotosPage += .page
  }
  
  private static func nextUserAlbumsPage() {
    userAlbumsPage += .page
  }
  
  private static func nextSearchAlbumsPage() {
    searchAlbumsPage += .page
  }
  
  private static func nextSearchUsersPage() {
    searchUsersPage += .page
  }
}

// MARK: - Extensions
extension String {
  static let page = "page"
  static let perPage = "per_page"
  static let query = "query"
  static let width = "w"
  static let devicePixelRatio = "dpr"
  static let username = "username"
  static let orientation = "orientation"
  static let orderBy = "order_by"
  static let contentFilter = "content_filter"
  static let landscape = "landscape"
  static let portrait = "portrait"
  static let squarish = "squarish"
  static let high = "high"
  static let latest = "latest"
}

private extension Int {
  static var page = 1
  static let perPage = 30
}
