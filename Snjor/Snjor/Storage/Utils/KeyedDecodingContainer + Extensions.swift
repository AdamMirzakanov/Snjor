//
//  KeyedDecodingContainer + Extensions.swift
//  Snjor
//
//  Created by Адам on 19.06.2024.
//

import Foundation

extension KeyedDecodingContainer {
  func decode(
    _ type: [Photo.URLKind: URL].Type,
    forKey key: Key
  ) throws -> [Photo.URLKind: URL] {
    let urlsDictionary = try self.decode(
      [String: String].self,
      forKey: key
    )
    var result = [Photo.URLKind: URL]()
    for (key, value) in urlsDictionary {
      if let kind = Photo.URLKind(rawValue: key),
         let url = URL(string: value) {
        result[kind] = url
      }
    }
    return result
  }
}
