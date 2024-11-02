//
//  Photo.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Foundation

struct Photo: Decodable, Hashable {
  // MARK: Internal Properties
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
  let tags: [Tag]?

  // MARK: Internal Enums
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

// MARK: - Downloadable
extension Photo: Downloadable {
  var downloadURL: URL? {
    return self.urls[.full]
  }
}

// MARK: - ViewModelItemRepresentable
extension Photo: ViewModelItemRepresentable {
  var title: String {
    return self.user.displayName
  }
  
  var regularURL: URL? {
    return self.urls[.thumb]
  }
}

// MARK: - Get profile image URL
extension Photo {
  var profileImageURL: URL? {
    return self.user.profileImage[.medium]
  }
}
