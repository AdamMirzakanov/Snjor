//
//  LocalDataImageService.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

protocol LocalDataImageServiceProtocol {
  func save(key: URL, data: Data?)
  func get(key: URL) -> Data?
}

struct LocalDataImageService: LocalDataImageServiceProtocol {

//  private var dataStorage = NSCache<NSURL, NSData>()
//  private let cacheQueue = DispatchQueue(label: "com.example.LocalDataImageService", qos: .background)
//
//  func save(key: URL, data: Data?) {
//    guard let data = data else { return }
//    cacheQueue.async {
//      self.dataStorage.setObject(data as NSData, forKey: key as NSURL)
//    }
//  }
//
//  func get(key: URL) -> Data? {
//    var cachedData: Data?
//    cacheQueue.sync {
//      cachedData = self.dataStorage.object(forKey: key as NSURL) as Data?
//    }
//    return cachedData
//  }


  private let cacheQueue = DispatchQueue(label: "com.example.LocalDataImageService", qos: .background)

  static let cache: URLCache = {
    let memoryCapacity = 50 * 1024 * 1024 // 50 MB
    let diskCapacity = 100 * 1024 * 1024 // 100 MB
    let diskPath = "unsplash"
    let cachesDirectory = FileManager.default.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    ).first!
    let cacheURL = cachesDirectory.appendingPathComponent(diskPath, isDirectory: true)
    return URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, directory: cacheURL)
  }()

  func save(key: URL, data: Data?) {
    guard let data = data else { return }
    let request = URLRequest(url: key)
    let response = URLResponse(url: key, mimeType: "image/jpeg", expectedContentLength: data.count, textEncodingName: nil)
    let cachedData = CachedURLResponse(response: response, data: data)
    LocalDataImageService.cache.storeCachedResponse(cachedData, for: request)
  }

  func get(key: URL) -> Data? {
    let request = URLRequest(url: key)
    return LocalDataImageService.cache.cachedResponse(for: request)?.data
  }
}
