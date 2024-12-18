//
//  LoadPhotosRepository.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка фотографий в сегменте Discover.
protocol LoadPhotosRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка фотографий в сегменте Discover.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[Photo]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchPhotos(request: URLRequest) async throws -> [Photo]
}

// MARK: - Struct
struct LoadPhotosRepository: LoadPhotosRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any NetworkServiceProtocol

  func fetchPhotos(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
