//
//  User.swift
//  Snjor
//
//  Created by Адам on 17.06.2024.
//

import Foundation

struct User: Decodable, Hashable {
  
  // MARK: Internal Properties
  let firstName: String?
  let lastName: String?
  let name: String?
  let username: String
  let profileImage: [ProfileImageSize: URL]
  let bio: String?
  let links: [LinkKind: URL]
  let location: String?
  let portfolioURL: URL?
  let totalCollections: Int
  let totalLikes: Int
  let totalPhotos: Int
  let id: String
  let social: Social?

  // MARK: Internal Enum
  enum ProfileImageSize: String, Decodable {
    case small
    case medium
    case large
  }

  enum LinkKind: String, Decodable {
    case html
    case photos
    case likes
    case portfolio
  }
}

// MARK: - Get display name
extension User {
  var displayName: String {
    if let name = name {
      return name
    }

    if let firstName = firstName {
      if let lastName = lastName {
        return "\(firstName) \(lastName)"
      }
      return firstName
    }

    return username
  }

  var profileURL: URL? {
    return URL(string: "https://unsplash.com/@\(username)")
  }
}
