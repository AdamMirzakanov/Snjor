//
//  User.swift
//  Snjor
//
//  Created by Адам on 17.06.2024.
//

import Foundation

struct User: Decodable, Hashable {
  // MARK: - Internal Properties
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

  // MARK: - Internal Enum
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

  // MARK: - Private Enum
  private enum CodingKeys: String, CodingKey {
    case id
    case username
    case firstName
    case lastName
    case name
    case profileImage
    case bio
    case links
    case location
    case portfolioURL
    case totalCollections
    case totalLikes
    case totalPhotos
    case social
  }

  // MARK: - Initializers
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    username = try container.decode(String.self, forKey: .username)
    firstName = try? container.decode(String.self, forKey: .firstName)
    lastName = try? container.decode(String.self, forKey: .lastName)
    name = try? container.decode(String.self, forKey: .name)
    profileImage = try container.decode([ProfileImageSize: URL].self, forKey: .profileImage)
    bio = try? container.decode(String.self, forKey: .bio)
    links = try container.decode([LinkKind: URL].self, forKey: .links)
    location = try? container.decode(String.self, forKey: .location)
    portfolioURL = try? container.decode(URL.self, forKey: .portfolioURL)
    totalCollections = try container.decode(Int.self, forKey: .totalCollections)
    totalLikes = try container.decode(Int.self, forKey: .totalLikes)
    totalPhotos = try container.decode(Int.self, forKey: .totalPhotos)
    social = try container.decode(Social.self, forKey: .social)
  }
}

// MARK: - Display Name
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
