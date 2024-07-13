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

  var downloaded = false

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

  private enum CodingKeys: String, CodingKey {
    case id
    case height
    case width
    case color
    case exif
    case user
    case urls
    case links
    case likesCount = "likes"
    case downloadsCount = "downloads"
    case viewsCount = "views"
    case blurHash
    case location
    case createdAt
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    height = try container.decode(Int.self, forKey: .height)
    width = try container.decode(Int.self, forKey: .width)
    exif = try? container.decode(PhotoExif.self, forKey: .exif)
    user = try container.decode(User.self, forKey: .user)
    urls = try container.decode([URLKind: URL].self, forKey: .urls)
    links = try container.decode([LinkKind: URL].self, forKey: .links)
    likes = try container.decode(Int.self, forKey: .likesCount)
    downloads = try? container.decode(Int.self, forKey: .downloadsCount)
    blurHash = try? container.decode(String.self, forKey: .blurHash)
    location = try? container.decode(Location.self, forKey: .location)
    createdAt = try container.decode(String.self, forKey: .createdAt)
  }
}

extension Photo: Downloadable {
  var downloadURL: URL? {
    return self.urls[.thumb]
  }
}

extension Photo {
  var regularURL: URL? {
    return self.urls[.regular]
  }
}
