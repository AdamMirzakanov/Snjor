//
//  Photo.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

struct Photo: Decodable, Hashable {
  // MARK: - Public Properties
  let width: Int
  let height: Int
  let urls: [URLKind: URL]
  let id: String
//  let blurHash: String
  let user: User

  // MARK: - Public Enum
  enum URLKind: String, Decodable, CodingKey {
    case raw
    case full
    case regular
    case small
    case thumb
  }

  // MARK: - Private Enum
//  private enum CodingKeys: String, CodingKey {
//    case width
//    case height
//    case urls
//    case id
//    case blurHash = "blur_hash"
//    case user
//  }
//
//  // MARK: - Initializers
//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//
//    // декодирование свойств
//    width = try container.decode(Int.self, forKey: .width)
//    height = try container.decode(Int.self, forKey: .height)
//    id = try container.decode(String.self, forKey: .id)
//    blurHash = try container.decode(String.self, forKey: .blurHash)
//    user = try container.decode(User.self, forKey: .user)
//
//    urls = try container.decode([URLKind: URL].self, forKey: .urls)
//  }
}
