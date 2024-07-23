//
//  PhotosAPIRequest.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import Foundation

protocol APIRequest {
  associatedtype Response
  var httpMethod: HTTPMethod { get }
  var urlRequest: URLRequest { get throws }
  func decodeResponse(data: Data) throws -> Response
}

struct PhotosAPIRequest: APIRequest {
  
  var query: [String: String]
  let id: String?
  
  init(query: [String : String], id: String? = nil) {
    self.query = query
    self.id = id
  }
  
  // MARK: - Protocol
  typealias Response = [TopicPhoto]
  
  var httpMethod: HTTPMethod {
    return .get
  }
  
  // https://api.unsplash.com/search/photos?page=1&query=R&per_page=30
  //
  var urlRequest: URLRequest {
    get throws {
      if let id = id {
        let path = Endpoints.getTopicPhotosEndpoint(id: id)
        let url = try Endpoints.createUrl(from: path, query: query)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = Endpoints.prepareHeaders()
        request.httpMethod = httpMethod.rawValue
        return request
      } else {
        let path = Endpoints.getTopicPhotosEndpoint()
        let url = try Endpoints.createUrl(from: path, query: query)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = Endpoints.prepareHeaders()
        request.httpMethod = httpMethod.rawValue
        return request
      }
      
    }
  }
  
  func decodeResponse(data: Data) throws -> [TopicPhoto] {
    let jsonDecoder = JSONDecoder()
    let listPhotos = try jsonDecoder.decode([TopicPhoto].self, from: data)
    return listPhotos
  }
}
