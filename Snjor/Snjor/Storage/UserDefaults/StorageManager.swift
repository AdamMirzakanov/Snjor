//
//  StorageManager.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.10.2024.
//

import Foundation

/// Менеджер для работы с UserDefaults, обеспечивающий сохранение и
/// восстановление данных различных типов.
/// - Конформит к `StorageManagerProtocol` для предоставления
/// необходимого функционала хранения данных.
final class StorageManager {
  
  // MARK: Public Enum
  /// Перечисление, представляющее ключи для доступа к сохранённым данным.
  public enum Key: String {
    
    /// Ключ для ориентации фотографии.
    case photoOrientationKey
    /// Ключ для индекса сегмента ориентации фотографии.
    case photoOrientationSegmentIndexKey
    
    /// Ключ для индекса сегмента сортировки фотографий.
    case sortingPhotosSegmentIndexKey
    /// Ключ для параметров сортировки фотографий.
    case sortingPhotosKey
    
    /// Ключ для выбранной кнопки круга.
    case selectedCircleButtonKey
    /// Ключ для индекса выбранной кнопки круга.
    case selectedCircleButtonIndexKey
  }
  
  // MARK: Private Properties
  /// Стандартный экземпляр `UserDefaults` для хранения данных.
  private let userDefaults = UserDefaults.standard
  
  /// Асинхронно сохраняет объект по указанному ключу.
  private func store(_ object: Any?, key: String) {
    DispatchQueue.global(qos: .userInteractive).async {
      self.userDefaults.set(object, forKey: key)
    }
  }
  
  /// Восстанавливает объект по указанному ключу.
  private func restore(forKey key: String) -> Any? {
    userDefaults.object(forKey: key)
  }
}

// MARK: - StorageManagerProtocol
extension StorageManager: StorageManagerProtocol {
  
  // MARK: Store Object
  func set(_ object: Any?, forKey key: Key) {
    store(object, key: key.rawValue)
  }
  
  func set<T: Encodable>(object: T?, forKey key: Key) {
    let jsonData = try? JSONEncoder().encode(object)
    store(jsonData, key: key.rawValue)
  }
  
  // MARK: Restore Object
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
  
  // MARK: Remove Object
  func remove(forKey key: Key) {
    userDefaults.removeObject(forKey: key.rawValue)
  }
}
