//
//  LoadAlbumPhotosRepositoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка фотографий отдельно вязтого альбома.
protocol LoadAlbumPhotosRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка фотографий отдельно вязтого альбома.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[Photo]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchAlbumPhotos(request: URLRequest) async throws -> [Photo]
}

// MARK: - Struct
struct LoadAlbumPhotosRepository: LoadAlbumPhotosRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any NetworkServiceProtocol
  
  func fetchAlbumPhotos(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
