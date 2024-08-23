//
//  PrepareParameters.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

typealias Parameters = [String: String]

enum PrepareParameters {
  // MARK: - Private  Properties
  static var page: Int = .page
  static var searchPhotosPage: Int = .page
  private static let perPage: Int = .perPage

  // MARK: - Internal Methods
  static func preparePhotoParameters() -> Parameters {
    nextPage()
    var parameters: [String: String] = [:]
    parameters[.page] = String(page)
    parameters[.perPage] = String(perPage)
    return parameters
  }
  
  static func prepareAlbumParameters() -> Parameters {
    nextPage()
    var parameters: [String: String] = [:]
    parameters[.page] = String(page)
    parameters[.perPage] = String(perPage)
    return parameters
  }

  static func prepareSearchPhotoParameters(with searchTerm: String) -> Parameters {
    nextSearchPhotosPage()
    var parameters: [String: String] = [:]
    parameters[.query] = searchTerm
    parameters[.page] = String(searchPhotosPage)
    parameters[.perPage] = String(perPage)
    print(searchPhotosPage)
    return parameters
  }
  
  // MARK: - Private  Methods
  private static func nextPage() {
    page += 1
  }
  
  private static func nextSearchPhotosPage() {
    searchPhotosPage += 1
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
