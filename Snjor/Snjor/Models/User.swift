//
//  User.swift
//  Snjor
//
//  Created by Адам on 17.06.2024.
//

import Foundation

struct User: Decodable, Hashable {
  let firstName: String?
  let lastName: String?
  let name: String?
  let username: String
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
