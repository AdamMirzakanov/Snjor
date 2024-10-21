//
//  StorageManagerProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.10.2024.
//

import Foundation

protocol StorageManagerProtocol {
  func set(_ object: Any?, forKey key: StorageManager.Key)
  func set<T: Encodable>(object: T?, forKey key: StorageManager.Key)
  
  func int(forKey key: StorageManager.Key) -> Int?
  func string(forKey key: StorageManager.Key) -> String?
  func dict(forKey key: StorageManager.Key) -> [String: Any]?
  func date(forKey key: StorageManager.Key) -> Date?
  func bool(forKey key: StorageManager.Key) -> Bool?
  func data(forKey key: StorageManager.Key) -> Data?
  func codableData<T: Decodable>(forKey key:  StorageManager.Key) -> T?
  func remove(forKey key: StorageManager.Key)
}
