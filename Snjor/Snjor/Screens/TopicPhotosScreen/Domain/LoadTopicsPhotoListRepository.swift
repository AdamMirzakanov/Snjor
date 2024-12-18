//
//  LoadTopicPhotosRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка фотографий отдельно вязтого топика.
protocol LoadTopicPhotosRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка фотографий отдельно вязтого топика.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[Photo]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchTopicsPhotoList(request: URLRequest) async throws -> [Photo]
}

// MARK: - Struct
struct LoadTopicPhotosRepository: LoadTopicPhotosRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any NetworkServiceProtocol
  
  func fetchTopicsPhotoList(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
