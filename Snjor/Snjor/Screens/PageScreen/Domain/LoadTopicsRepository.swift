//
//  LoadTopicsPageRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку страницы с топиками.
protocol LoadTopicsPageRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка топиков.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[Topic]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchTopic(request: URLRequest) async throws -> [Topic]
}

// MARK: - Struct
/// Репозиторий для загрузки страницы с топиками.
struct LoadTopicsPageRepository: LoadTopicsPageRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any Requestable
  
  func fetchTopic(request: URLRequest) async throws -> [Topic] {
    return try await networkService.request(
      request: request,
      type: [Topic].self
    )
  }
}
