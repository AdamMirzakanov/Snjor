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
    var result: [Photo.URLKind: URL] = [:]

    for (key, value) in urlsDictionary {
      if let kind = Photo.URLKind(rawValue: key),
        let url = URL(string: value) {
        result[kind] = url
      }
    }
    return result
  }

  func decode(
    _ type: [Photo.LinkKind: URL].Type,
    forKey key: Key
  ) throws -> [Photo.LinkKind: URL] {
    let linksDictionary = try self.decode(
      [String: String].self,
      forKey: key
    )
    var result: [Photo.LinkKind: URL] = [:]

    for (key, value) in linksDictionary {
      if let kind = Photo.LinkKind(rawValue: key),
        let url = URL(string: value) {
        result[kind] = url
      }
    }
    return result
  }

  func decode(
    _ type: [User.ProfileImageSize: URL].Type,
    forKey key: Key
  ) throws -> [User.ProfileImageSize: URL] {
    let sizesDictionary = try self.decode(
      [String: String].self,
      forKey: key
    )
    var result: [User.ProfileImageSize: URL] = [:]

    for (key, value) in sizesDictionary {
      if let size = User.ProfileImageSize(rawValue: key),
        let url = URL(string: value) {
        result[size] = url
      }
    }
    return result
  }

  func decode(
    _ type: [User.LinkKind: URL].Type,
    forKey key: Key
  ) throws -> [User.LinkKind: URL] {
    let urlsDictionary = try self.decode(
      [String: String].self,
      forKey: key
    )
    var result: [User.LinkKind: URL] = [:]

    for (key, value) in urlsDictionary {
      if let kind = User.LinkKind(rawValue: key),
        let url = URL(string: value) {
        result[kind] = url
      }
    }
    return result
  }
}
