//
//  Photo.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Foundation

struct Photo: Decodable, Hashable {
  // MARK: - Internal Properties
  let width: Int
  let height: Int
  let urls: [URLKind: URL]
  var id: String
  let blurHash: String?
  let user: User
  let downloads: Int?
  let likes: Int?
  let exif: PhotoExif?
  let links: [LinkKind: URL]
  let createdAt: String
  let location: Location?

  // MARK: - Internal Enum
  enum URLKind: String, Decodable {
    case raw
    case full
    case regular
    case small
    case thumb
  }

  enum LinkKind: String, Decodable {
    case own = "self"
    case html
    case download
    case downloadLocation
  }
}

// MARK: - URLs
extension Photo: Downloadable {
  var downloadURL: URL? {
    return self.urls[.regular]
  }
}

extension Photo {
  var regularURL: URL? {
    return self.urls[.regular]
  }
}

extension Photo {
  var profileImageURL: URL? {
    return self.user.profileImage[.medium]
  }
}


struct TopicPhoto: Decodable {
  let width: Int
  let height: Int
  let urls: [URLKind: URL]
  var id: String
  
  enum URLKind: String, Decodable, CodingKey {
    case raw
    case full
    case regular
    case small
    case thumb
  }
  
  private enum CodingKeys: String, CodingKey {
    case width
    case height
    case urls
    case id
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    width = try container.decode(Int.self, forKey: .width)
    height = try container.decode(Int.self, forKey: .height)
    id = try container.decode(String.self, forKey: .id)
    
    let urlsContainer = try container.nestedContainer(
      keyedBy: URLKind.self,
      forKey: .urls
    )
    
    urls = try urlsContainer.allKeys.reduce(into: [:]) { result, key in
      if let kind = URLKind(rawValue: key.rawValue),
         let url = try urlsContainer.decodeIfPresent(URL.self, forKey: key) {
        result[kind] = url
      }
    }
  }
}
