//
//  ImageCacheService.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

enum ImageCacheService {
  
  // MARK: Internal Properties
  private static let memoryCapacity: Int = 50.megabytes
  private static let diskCapacity: Int = 100.megabytes

  // MARK: Internal Methods
  static let cache: URLCache = {
    let diskPath: String = .diskPath
    // swiftlint:disable force_unwrapping
    let cachesDirectory = FileManager.default.urls(
      for: .cachesDirectory,
      in: .userDomainMask).first!
    // swiftlint:enable force_unwrapping
    let cacheURL = cachesDirectory.appendingPathComponent(
      diskPath,
      isDirectory: true
    )
    return URLCache(
      memoryCapacity: memoryCapacity,
      diskCapacity: diskCapacity,
      directory: cacheURL
    )
  }()
}

// MARK: - Int
private extension Int {
  var megabytes: Int { return self * 1024 * 1024 }
}

// MARK: - String
private extension String {
  static let diskPath = "snjor"
}
