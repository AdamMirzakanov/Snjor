//
//  PrepareRequests.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

enum PrepareRequests {
  // MARK: - Private Properties
  private static var httpMethod: HTTPMethod { .get }
  private static var scheme: API { .scheme }
  private static var host: API { .host }
  private static var accessKey: Authorization { .accessKey }

  // MARK: - Public Methods
  static func prepareURLRequest(
    path: String,
    parameters: [String: String]
  ) throws -> URLRequest {
    guard let url = prepareURL(
      from: path,
      parameters: parameters
    ) else {
      throw APIError.URLError
    }

    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = prepareHeaders()
    request.httpMethod = httpMethod.rawValue
    return request
  }

  static func prepareHeaders() -> [String: String] {
    var headers: [String: String] = [:]
    headers["Authorization"] = "Client-ID \(accessKey.rawValue)"
    return headers
  }

  // MARK: - Private Methods
  private static func prepareURL(
    from path: String,
    parameters: [String: String]
  ) -> URL? {
    let components = prepareURLComponents(
      from: path,
      parameters: parameters)
    let url = components.url
    return url
  }

  private static func prepareURLComponents(
    from path: String,
    parameters: [String: String]
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = scheme.rawValue
    components.host = host.rawValue
    components.path = path
    components.queryItems = prepareQueryItems(parameters: parameters)
    return components
  }

  private static func prepareQueryItems(parameters: [String: String]) -> [URLQueryItem] {
    parameters.map { URLQueryItem(
      name: $0.key,
      value: $0.value)
    }
  }
}
