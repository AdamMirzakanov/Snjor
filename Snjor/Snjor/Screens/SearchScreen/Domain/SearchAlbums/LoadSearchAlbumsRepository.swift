//
//  LoadSearchAlbumsRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка альбомов по поисковому запросу.
protocol LoadSearchAlbumsRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка альбомов по поисковому запросу.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[SearchAlbums]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchSearchAlbums(request: URLRequest) async throws -> SearchAlbums
}

// MARK: - Struct
struct LoadSearchAlbumsRepository: LoadSearchAlbumsRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any NetworkServiceProtocol
  
  func fetchSearchAlbums(request: URLRequest) async throws -> SearchAlbums {
    return try await networkService.request(
      request: request,
      type: SearchAlbums.self
    )
  }
}
