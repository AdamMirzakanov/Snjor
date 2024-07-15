//
//  PrepareParameters.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

typealias Parameters = [String: String]

enum PrepareParameters {
  // MARK: - Internal Properties
  static var page: Int = .page
  private static let perPage: Int = .perPage

  // MARK: - Internal Methods
  static func preparePhotoParameters() -> Parameters {
    page += 1
    var parameters: [String: String] = [:]
    parameters[.page] = String(page)
    parameters[.perPage] = String(perPage)
    return parameters
  }

  static func prepareSearchPhotoParameters(with searchTerm: String) -> Parameters {
    var parameters: [String: String] = [:]
    parameters[.query] = searchTerm
    parameters[.page] = String(page)
    parameters[.perPage] = String(perPage)
    return parameters
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
