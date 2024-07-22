//
//  Endpoints.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

enum Endpoints: String {
  case photos = "/photos"
  case photo = "/photos/"
  case searchPhotos = "/search/photos"
  case topics = "/topics/"
  case collections = "/collections"
  case searchCollections = "/search/collections"
  static func prepareHeaders() -> [String: String] {
    var headers = [String: String]()
    let token = "Client-ID rcKlvKOv4ZNiLed47VZnync8ynWaNDNYw0MxZ5Tqiko"
    headers["Authorization"] = token
    return headers
  }
  
  static func createUrl(
    from path: String
  ) throws -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.unsplash.com"
    components.path = path
    guard let url = components.url else { throw APIError.URLError }
    return url
  }
}
