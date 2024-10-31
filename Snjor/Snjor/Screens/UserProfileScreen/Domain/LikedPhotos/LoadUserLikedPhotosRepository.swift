//
//  LoadUserLikedPhotosRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.09.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка фотографий лайкнутых пользователем.
protocol LoadUserLikedPhotosRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка фотографий лайкнутых пользователем.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[Photo]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchPhotos(request: URLRequest) async throws -> [Photo]
}

// MARK: - Struct
struct LoadUserLikedPhotosRepository: LoadUserLikedPhotosRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any Requestable
  
  func fetchPhotos(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
