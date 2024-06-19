//
//  PrepareParameters.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

typealias Parameters = [String: String]

enum PrepareParameters {
  // MARK: - Public Properties
//  static var page: Int {
//    Int.random(in: 0...10000)
//  }

  static var page: Int = 1
  private static let perPage: Int = 15

  // MARK: - Public Methods
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
