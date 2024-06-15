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
  let color: UIColor?
  let blurHash: String

  // MARK: - Public Enum
  enum URLKind: String, Decodable, CodingKey {
    case raw
    case full
    case regular
    case small
    case thumb
  }

  // MARK: - Private Enum
  private enum CodingKeys: String, CodingKey {
    case width
    case height
    case urls
    case id
    case color
    case blurHash = "blur_hash"
  }

  // MARK: - Initializers
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    // декодирование свойств
    width = try container.decode(Int.self, forKey: .width)
    height = try container.decode(Int.self, forKey: .height)
    id = try container.decode(String.self, forKey: .id)
    blurHash = try container.decode(String.self, forKey: .blurHash)

    if let hexString = try? container.decode(String.self, forKey: .color) {
      color = UIColor(hexString: hexString)
    } else {
      color = nil
    }

    let urlsContainer = try container.nestedContainer(
      keyedBy: URLKind.self,
      forKey: .urls
    )

    urls = try urlsContainer.allKeys.reduce(into: [:]) { result, key in
      guard let kind = URLKind(rawValue: key.rawValue) else { return }
      guard let url = try urlsContainer.decodeIfPresent(
        URL.self,
        forKey: key
      ) else { return }
      result[kind] = url
    }
  }
}
