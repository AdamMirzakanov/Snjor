//
//  LoadAlbumsRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка альбомов в сегменте Topic & Albums.
protocol LoadAlbumsRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка фотографий в сегменте Topic & Albums.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[Album]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchAlbumList(request: URLRequest) async throws -> [Album]
}

// MARK: - Struct
struct LoadAlbumsRepository: LoadAlbumsRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any Requestable

  func fetchAlbumList(request: URLRequest) async throws -> [Album] {
    return try await networkService.request(request: request, type: [Album].self)
  }
}
