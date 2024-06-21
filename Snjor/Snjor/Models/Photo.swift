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
  let exif: PhotoExif?
  let links: [LinkKind: URL]

  // MARK: - Public Enum
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
