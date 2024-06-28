//
//  LocalDataImageService.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

protocol LocalDataImageServiceProtocol {
  func save(key: String, data: Data?)
  func get(key: String) -> Data?
}

struct LocalDataImageService: LocalDataImageServiceProtocol {

  private var dataStorage = NSCache<NSString, NSData>()

  func save(key: String, data: Data?) {
    guard let data = data else { return }
    dataStorage.setObject(data as NSData, forKey: key as NSString)
  }

  // 1
  func get(key: String) -> Data? {
    return dataStorage.object(forKey: key as NSString) as? Data
  }
}
