//
//  KeyedDecodingContainer + Extensions.swift
//  Snjor
//
//  Created by Адам on 19.06.2024.
//

import Foundation

extension KeyedDecodingContainer {
  /// Декодирует словарь, где ключи - это типы `Photo.URLKind`, а значения - `URL`.
  /// - Parameter key: Ключ для доступа к данным в контейнере.
  /// - Throws: Ошибка, если декодирование не удалось.
  /// - Returns: Словарь с типами `Photo.URLKind` в качестве ключей и `URL` в качестве значений.
  func decode(
    _ type: [Photo.URLKind: URL].Type,
    forKey key: Key
  ) throws -> [Photo.URLKind: URL] {
    let urlsDictionary = try self.decode(
      [String: String].self,
      forKey: key
    )
    
    // Декодируем словарь строковых ключей и значений.
    // Перебираем декодированные значения и конвертируем их в соответствующий тип.
    // Сохраняем в результирующий словарь.
    // Возвращаем результирующий словарь.
    var result: [Photo.URLKind: URL] = [:]
    
    for (key, value) in urlsDictionary {
      if let kind = Photo.URLKind(rawValue: key),
         let url = URL(string: value) {
        result[kind] = url
      }
    }
    return result
  }
  
  /// Декодирует словарь, где ключи - это типы `Photo.LinkKind`, а значения - `URL`.
  /// - Parameter key: Ключ для доступа к данным в контейнере.
  /// - Throws: Ошибка, если декодирование не удалось.
  /// - Returns: Словарь с типами `Photo.LinkKind` в качестве ключей и `URL` в качестве значений.
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
  
  /// Декодирует словарь, где ключи - это типы `User.ProfileImageSize`, а значения - `URL`.
  /// - Parameter key: Ключ для доступа к данным в контейнере.
  /// - Throws: Ошибка, если декодирование не удалось.
  /// - Returns: Словарь с типами `User.ProfileImageSize` в качестве ключей и `URL` в качестве значений.
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
  
  /// Декодирует словарь, где ключи - это типы `User.LinkKind`, а значения - `URL`.
  /// - Parameter key: Ключ для доступа к данным в контейнере.
  /// - Throws: Ошибка, если декодирование не удалось.
  /// - Returns: Словарь с типами `User.LinkKind` в качестве ключей и `URL` в качестве значений.
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
