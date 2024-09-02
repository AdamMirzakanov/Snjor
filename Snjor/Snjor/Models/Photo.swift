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

extension Photo: HasRegularURL {
  var title: String {
    return self.user.displayName
  }
  
  var regularURL: URL? {
    return self.urls[.regular]
  }
}

extension Photo {
  var profileImageURL: URL? {
    return self.user.profileImage[.medium]
  }
}

// MARK: - HasRegularURL
protocol HasRegularURL {
  var regularURL: URL? { get }
  var id: String { get }
  var title: String { get }
}
