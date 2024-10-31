//
//  LoadUserAlbumsRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка альбомов пользователя.
protocol LoadUserAlbumsRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка альбомов пользователя.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[Album]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchPhotos(request: URLRequest) async throws -> [Album]
}

// MARK: - Struct
struct LoadUserAlbumsRepository: LoadUserAlbumsRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any Requestable
  
  func fetchPhotos(request: URLRequest) async throws -> [Album] {
    return try await networkService.request(
      request: request,
      type: [Album].self
    )
  }
}
