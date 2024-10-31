//
//  LoadSearchPhotosRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка фотографий по поисковому запросу.
protocol LoadSearchPhotosRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка фотографий по поисковому запросу.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[SearchPhotos]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchSearchPhotos(request: URLRequest) async throws -> SearchPhotos
}

// MARK: - Struct
struct LoadSearchPhotosRepository: LoadSearchPhotosRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any Requestable
  
  func fetchSearchPhotos(request: URLRequest) async throws -> SearchPhotos {
    return try await networkService.request(
      request: request,
      type: SearchPhotos.self
    )
  }
}
