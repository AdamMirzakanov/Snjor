//
//  User.swift
//  Snjor
//
//  Created by Адам on 17.06.2024.
//

import Foundation

struct User: Codable, Hashable {
  let firstName: String?
  let lastName: String?
  let name: String?
  let username: String

  private enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case lastName = "last_name"
    case name
    case username
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    username = try container.decode(String.self, forKey: .username)
    firstName = try? container.decode(String.self, forKey: .firstName)
    lastName = try? container.decode(String.self, forKey: .lastName)
    name = try? container.decode(String.self, forKey: .name)
  }
}

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
}
