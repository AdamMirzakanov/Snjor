//
//  StorageManagerProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.10.2024.
//

import Foundation

protocol StorageManagerProtocol {
  func set(_ object: Any?, forKey key: StorageManager.Keys)
  func set<T: Encodable>(object: T?, forKey key: StorageManager.Keys)
  
  func int(forKey key: StorageManager.Keys) -> Int?
  func string(forKey key: StorageManager.Keys) -> String?
  func dict(forKey key: StorageManager.Keys) -> [String: Any]?
  func date(forKey key: StorageManager.Keys) -> Date?
  func bool(forKey key: StorageManager.Keys) -> Bool?
  func data(forKey key: StorageManager.Keys) -> Data?
  func codableData<T: Decodable>(forKey key:  StorageManager.Keys) -> T?
  func remove(forKey key: StorageManager.Keys)
}
