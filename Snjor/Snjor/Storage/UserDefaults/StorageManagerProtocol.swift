//
//  StorageManagerProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.10.2024.
//

import Foundation

/// Протокол, определяющий интерфейс для менеджера хранения данных в `UserDefaults`.
/// Обеспечивает методы для сохранения, восстановления и удаления данных различных типов.
protocol StorageManagerProtocol {
  
  // MARK: Store Object
  /// Сохраняет объект по указанному ключу.
  /// - Parameters:
  ///   - object: Объект для сохранения (может быть `nil`).
  ///   - key: Ключ для доступа к сохранённому объекту.
  func set(_ object: Any?, forKey key: StorageManager.Key)
  
  /// Сохраняет объект, который соответствует протоколу `Encodable`, по указанному ключу.
  /// - Parameters:
  ///   - object: Объект, который нужно сохранить (может быть `nil`).
  ///   - key: Ключ для доступа к сохранённому объекту.
  func set<T: Encodable>(object: T?, forKey key: StorageManager.Key)
  
  // MARK: Restore Object
  /// Восстанавливает целое число по указанному ключу.
  /// - Parameter key: Ключ для доступа к сохранённому объекту.
  /// - Returns: Восстановленное целое число или `nil`, если значение не найдено.
  func int(forKey key: StorageManager.Key) -> Int?
  
  /// Восстанавливает строку по указанному ключу.
  /// - Parameter key: Ключ для доступа к сохранённому объекту.
  /// - Returns: Восстановленная строка или `nil`, если значение не найдено.
  func string(forKey key: StorageManager.Key) -> String?
  
  /// Восстанавливает словарь по указанному ключу.
  /// - Parameter key: Ключ для доступа к сохранённому объекту.
  /// - Returns: Восстановленный словарь или `nil`, если значение не найдено.
  func dict(forKey key: StorageManager.Key) -> [String: Any]?
  
  /// Восстанавливает дату по указанному ключу.
  /// - Parameter key: Ключ для доступа к сохранённому объекту.
  /// - Returns: Восстановленная дата или `nil`, если значение не найдено.
  func date(forKey key: StorageManager.Key) -> Date?
  
  /// Восстанавливает булево значение по указанному ключу.
  /// - Parameter key: Ключ для доступа к сохранённому объекту.
  /// - Returns: Восстановленное булево значение или `nil`, если значение не найдено.
  func bool(forKey key: StorageManager.Key) -> Bool?
  
  /// Восстанавливает данные по указанному ключу.
  /// - Parameter key: Ключ для доступа к сохранённому объекту.
  /// - Returns: Восстановленные данные или `nil`, если значение не найдено.
  func data(forKey key: StorageManager.Key) -> Data?
  
  /// Восстанавливает объект, который соответствует протоколу `Decodable`, по указанному ключу.
  /// - Parameter key: Ключ для доступа к сохранённому объекту.
  /// - Returns: Восстановленный объект или `nil`, если значение не найдено.
  func codableData<T: Decodable>(forKey key: StorageManager.Key) -> T?
  
  // MARK: Remove Object
  /// Удаляет объект по указанному ключу.
  /// - Parameter key: Ключ для доступа к удаляемому объекту.
  func remove(forKey key: StorageManager.Key)
}
