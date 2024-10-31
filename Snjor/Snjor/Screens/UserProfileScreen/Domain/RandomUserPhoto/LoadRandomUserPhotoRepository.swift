//
//  LoadRandomUserPhotoRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.09.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку случайной фотографии
/// - Note: Случайная фотография загружается из числа фотографий пользователя,
/// кроме того фотография отбирается исключительно в портретной ориентации.
protocol LoadRandomUserPhotoRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку случайной фотографии.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает объект типа `Photo`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  /// - Note: Случайная фотография загружается из числа фотографий пользователя,
  /// кроме того фотография отбирается исключительно в портретной ориентации.
  func fetchPhoto(request: URLRequest) async throws -> Photo
}

// MARK: - Struct
struct LoadRandomUserPhotoRepository: LoadRandomUserPhotoRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any Requestable
  
  func fetchPhoto(request: URLRequest) async throws -> Photo {
    return try await networkService.request(
      request: request,
      type: Photo.self
    )
  }
}
