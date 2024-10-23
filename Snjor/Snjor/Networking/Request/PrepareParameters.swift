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
    parameters[ParamKey.page.rawValue] = String(photosPage)
    parameters[ParamKey.perPage.rawValue] = String(perPage)
    return parameters
  }
  
  static func prepareAlbumParameters() -> Parameters {
    nextAlbumsPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(albumsPage)
    parameters[ParamKey.perPage.rawValue] = String(perPage)
    return parameters
  }
  
  static func prepareUserLikedPhotosParameters() -> Parameters {
    nextUserLikedPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(userLikedPhotosPage)
    parameters[ParamKey.perPage.rawValue] = String(perPage)
    return parameters
  }
  
  static func prepareUserPhotosParameters() -> Parameters {
    nextUserPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(userPhotosPage)
    parameters[ParamKey.perPage.rawValue] = String(perPage)
    return parameters
  }
  
  static func prepareRandomUserPhotoParameters(username: String) -> Parameters {
    var parameters: Parameters = [:]
    parameters[ParamKey.username.rawValue] = username
    parameters[ParamKey.orientation.rawValue] = ParamValue.portrait.rawValue
    return parameters
  }
  
  static func prepareUserAlbumsParameters() -> Parameters {
    nextUserAlbumsPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(userAlbumsPage)
    parameters[ParamKey.perPage.rawValue] = String(perPage)
    return parameters
  }
  
  static func prepareSearchPhotoParameters(with searchTerm: String) -> Parameters {
    nextSearchPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.query.rawValue] = searchTerm
    parameters[ParamKey.page.rawValue] = String(searchPhotosPage)
    parameters[ParamKey.perPage.rawValue] = String(perPage)
    
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
  
  static func prepareSearchAlbumsParameters(with searchTerm: String) -> Parameters {
    nextSearchAlbumsPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.query.rawValue] = searchTerm
    parameters[ParamKey.page.rawValue] = String(searchAlbumsPage)
    parameters[ParamKey.perPage.rawValue] = String(perPage)
    return parameters
  }
  
  static func prepareSearchUsersParameters(with searchTerm: String) -> Parameters {
    nextSearchUsersPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.query.rawValue] = searchTerm
    parameters[ParamKey.page.rawValue] = String(searchUsersPage)
    parameters[ParamKey.perPage.rawValue] = String(perPage)
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

// MARK: - Int
private extension Int {
  static var page = 1
  static let perPage = 30
}
