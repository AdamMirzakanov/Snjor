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
  let blurHash: String?
  let user: User

  // MARK: - Public Enum
  enum URLKind: String, Decodable, CodingKey {
    case raw
    case full
    case regular
    case small
    case thumb
  }
}
