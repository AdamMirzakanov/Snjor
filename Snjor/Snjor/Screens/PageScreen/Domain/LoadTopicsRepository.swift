//
//  LoadTopicsPageRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка топиков  (Шапка топиков без содержимого).
protocol LoadTopicsPageRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка топиков (Шапка топиков без содержимого).
  ///
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  ///
  /// - Для экрана `PageScreenViewController` -  Метки с названиями топиков
  ///   - Первая вкладка `MainTabBArController`
  ///
  /// - Для экрана `SearchScreenViewController` в сегменте Topic & Albums - Метки с названиями топиков + обложки
  ///   - Вторая вкладка `MainTabBArController`
  ///
  /// - Returns: Возвращает массив объектов типа `[Topic]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchTopic(request: URLRequest) async throws -> [Topic]
}

// MARK: - Struct
/// Репозиторий для загрузки страницы с топиками отвечающий
/// за загрузку списка топиков (Шапка топиков без содержимого).
///
/// - Для экрана `PageScreenViewController` -  Метки с названиями топиков
///   - Первая вкладка `MainTabBArController`
///
/// - Для экрана `SearchScreenViewController` в сегменте Topic & Albums - Метки с названиями топиков + обложки
///   - Вторая вкладка `MainTabBArController`
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
