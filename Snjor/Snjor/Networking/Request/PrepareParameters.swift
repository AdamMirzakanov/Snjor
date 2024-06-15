//
//  PrepareParameters.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

typealias Parameters = [String: String]

enum PrepareParameters {
  // MARK: - Public Properties
  static var page = 0
  private static let perPage = 30

  // MARK: - Public Methods
  static func preparePhotoParameters() -> Parameters {
    let parameters = [
      "page": String(page),
      "per_page": String(perPage)
    ]
    return parameters
  }

  static func prepareSearchPhotoParameters(with searchTerm: String) -> Parameters {
    let parameters = [
      "query": searchTerm,
      "page": String(page),
      "per_page": String(perPage)
    ]
    return parameters
  }
}
