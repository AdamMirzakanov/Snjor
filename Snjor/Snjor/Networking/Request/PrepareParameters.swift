//
//  PrepareParameters.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

typealias Parameters = [String: String]

enum PrepareParameters {
  // MARK: - Internal Properties
  static var page: Int = 1
  private static let perPage: Int = 30

  // MARK: - Internal Methods
  static func preparePhotoParameters() -> Parameters {
    page += 1
    var parameters: [String: String] = [:]
    parameters["page"] = String(page)
    parameters["per_page"] = String(perPage)
    return parameters
  }

  static func prepareSearchPhotoParameters(with searchTerm: String) -> Parameters {
    var parameters: [String: String] = [:]
    parameters["query"] = searchTerm
    parameters["page"] = String(page)
    parameters["per_page"] = String(perPage)
    return parameters
  }
}
