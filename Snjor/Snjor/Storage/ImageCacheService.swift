//
//  ImageCacheService.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// Служба кэширования изображений, которая управляет кэшом для хранения загруженных
/// изображений в памяти и на диске.
enum ImageCacheService {
  // MARK: Private Properties
  private static let memoryCapacity: Int = 50.megabytes
  private static let diskCapacity: Int = 100.megabytes
  
  // MARK: Static Properties
  /// Статический экземпляр `URLCache`, который инициализируется с заданными
  /// параметрами объема памяти и объема диска для кэширования изображений.
  ///
  /// - Процесс инициализации:
  ///   1. Получает путь к директории кэша на диске с использованием `FileManager`.
  ///   2. Создает `URLCache` с указанными значениями `memoryCapacity` и `diskCapacity`,
  ///      а также указывает директорию для хранения кэшированных данных.
  ///   3. Использует `force_unwrapping` для получения первого элемента из массива
  ///      директорий кэша, так как предполагается, что он всегда будет доступен.
  ///
  /// Этот кэш используется для хранения изображений, чтобы уменьшить количество
  /// сетевых запросов и повысить производительность приложения.
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
  /// Расширение для типа `Int`, добавляющее удобное вычисляемое
  /// свойство для конвертации значения в мегабайты.
  ///
  /// Умножает текущее значение на 1024, а затем еще раз на 1024,
  /// что позволяет легко преобразовать количество мегабайт в байты.
  /// Это свойство используется для упрощения задания объемов памяти
  /// при конфигурации кэша.
  var megabytes: Int { return self * 1024 * 1024 }
}

// MARK: - String
private extension String {
  static let diskPath = "snjor"
}
