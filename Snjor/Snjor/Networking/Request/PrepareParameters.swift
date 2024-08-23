//
//  PrepareParameters.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

typealias Parameters = [String: String]

enum PrepareParameters {
  
  // MARK: - Internal Properties
  static var photosPage: Int = .page
  static var searchPhotosPage: Int = .page
  static var albumsPage: Int = .page
  static var searchAlbumsPage: Int = .page
  
  // MARK: - Private  Properties
  private static let perPage: Int = .perPage

  // MARK: - Internal Methods
  static func preparePhotoParameters() -> Parameters {
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

  static func prepareSearchPhotoParameters(with searchTerm: String) -> Parameters {
    nextSearchPhotosPage()
    var parameters: Parameters = [:]
    parameters[.query] = searchTerm
    parameters[.page] = String(searchPhotosPage)
    parameters[.perPage] = String(perPage)
    print(searchPhotosPage)
    return parameters
  }
  
  // MARK: - Private  Methods
  private static func nextPhotosPage() {
    photosPage += 1
  }
  
  private static func nextSearchPhotosPage() {
    searchPhotosPage += 1
  }
  
  private static func nextAlbumsPage() {
    albumsPage += 1
  }
  
  private static func nextSearchAlbumsPage() {
    searchAlbumsPage += 1
  }
}

// MARK: - String Extension
extension String {
  static let page = "page"
  static let perPage = "per_page"
  static let query = "query"
  static let width = "w"
  static let devicePixelRatio = "dpr"
}

// MARK: - Int Extension
private extension Int {
  static var page = 1
  static let perPage = 30
}
