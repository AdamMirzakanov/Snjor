//
//  StorageManager.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.10.2024.
//

import Foundation

final class StorageManager {
  // MARK: Public Enum
  public enum Key: String {
    case photoOrientationKey
    case photoOrientationSegmentIndexKey
    
    case sortingPhotosSegmentIndexKey
    case sortingPhotosKey
    
    case selectedCircleButtonKey
    case selectedCircleButtonIndexKey
  }
  
  // MARK: Private Properties
  private let userDefaults = UserDefaults.standard
  
  private func store(_ object: Any?, key: String) {
    DispatchQueue.global(qos: .userInteractive).async {
      self.userDefaults.set(object, forKey: key)
    }
  }
  
  private func restore(forKey key: String) -> Any? {
    userDefaults.object(forKey: key)
  }
}

// MARK: - StorageManagerProtocol
extension StorageManager: StorageManagerProtocol {
  func set(_ object: Any?, forKey key: Key) {
    store(object, key: key.rawValue)
  }
  
  func set<T: Encodable>(object: T?, forKey key: Key) {
    let jsonData = try? JSONEncoder().encode(object)
    store(jsonData, key: key.rawValue)
  }
  
  func int(forKey key: Key) -> Int? {
    restore(forKey: key.rawValue) as? Int
  }
  
  func string(forKey key: Key) -> String? {
    restore(forKey: key.rawValue) as? String
  }
  
  func dict(forKey key: Key) -> [String : Any]? {
    restore(forKey: key.rawValue) as?  [String : Any]
  }
  
  func date(forKey key: Key) -> Date? {
    restore(forKey: key.rawValue) as? Date
  }
  
  func bool(forKey key: Key) -> Bool? {
    restore(forKey: key.rawValue) as? Bool
  }
  
  func data(forKey key: Key) -> Data? {
    restore(forKey: key.rawValue) as? Data
  }
  
  func codableData<T: Decodable>(forKey key: Key) -> T? {
    guard let data = restore(forKey: key.rawValue) as? Data else {
      return nil
    }
    return try? JSONDecoder().decode(T.self, from: data)
  }
  
  func remove(forKey key: Key) {
    userDefaults.removeObject(forKey: key.rawValue)
  }
}
