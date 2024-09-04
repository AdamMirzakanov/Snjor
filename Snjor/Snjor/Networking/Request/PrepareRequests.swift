//
//  PrepareRequests.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

enum PrepareRequests {
  // MARK: Private Properties
  private static var getHTTP: HTTPMethod { .get }
  private static var scheme: API { .scheme }
  private static var host: API { .host }
  private static var accessKey: Authorization { .accessKey }

  // MARK: Internal Methods
  static func prepareTopicsTitleAPIRequest(topics: String) throws -> URLRequest {
    guard let url = prepareURL(from: topics) else {
      throw APIError.URLError
    }
    let request = prepareURLRequest(url: url)
    return request
  }
  
  static func prepareTopicPhotosAPIRequest(
    topics: String,
    id: String,
    phtos: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: topics, parameters: parameters) else {
      throw APIError.URLError
    }
    let topicsIdURL = url.appending(path: id)
    let topicsPhotosURL = topicsIdURL.appending(path: phtos)
    let request = prepareURLRequest(url: topicsPhotosURL)
    return request
  }
  
  static func prepareAlbumPhotosAPIRequest(
    albums: String,
    id: String,
    phtos: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: albums, parameters: parameters) else {
      throw APIError.URLError
    }
    let albumIdURL = url.appending(path: id)
    let albumPhotosURL = albumIdURL.appending(path: phtos)
    let request = prepareURLRequest(url: albumPhotosURL)
    return request
  }
  
  static func preparePhotoInfoAPIRequest(
    path: String,
    id: String
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path) else {
      throw APIError.URLError
    }
    let photoInfoURL = url.appending(component: id)
    let request = prepareURLRequest(url: photoInfoURL)
    return request
  }

  static func prepareAPIRequest(
    path: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let request = prepareURLRequest(url: url)
    return request
  }

  // MARK: Private Methods
  private static func prepareURLRequest(url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = prepareHeaders()
    request.httpMethod = getHTTP.rawValue
    return request
  }
  
  private static func prepareURL(
    from path: String,
    parameters: Parameters? = nil
  ) -> URL? {
    if let parameters = parameters {
      let components = prepareURLComponents(from: path, parameters: parameters)
      return components.url
    } else {
      let components = prepareURLComponents(from: path)
      return components.url
    }
  }

  private static func prepareURLComponents(
    from path: String,
    parameters: Parameters? = nil
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = scheme.rawValue
    components.host = host.rawValue
    components.path = path
    if let parameters = parameters {
      components.queryItems = prepareQueryItems(parameters: parameters)
    }
    return components
  }

  private static func prepareQueryItems(
    parameters: Parameters
  ) -> [URLQueryItem] {
    parameters.map { URLQueryItem(
      name: $0.key,
      value: $0.value)
    }
  }

  private static func prepareHeaders() -> Parameters {
    var headers: Parameters = [:]
    headers["Authorization"] = "Client-ID " + accessKey.rawValue
    return headers
  }
}
