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

  private var dataStorage = NSCache<NSURL, NSData>()

  func save(key: URL, data: Data?) {
    guard let data = data else { return }
    dataStorage.setObject(data as NSData, forKey: key as NSURL)
  }

  func get(key: URL) -> Data? {
    dataStorage.object(forKey: key as NSURL) as? Data
  }
}
