//
//  LoadTopicsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки списка топиков (Шапка топиков без содержимого).
///
/// - Для экрана `PageScreenViewController` -  Метки с названиями топиков
///   - Первая вкладка `MainTabBArController`
///
/// - Для экрана `SearchScreenViewController` в сегменте Topic & Albums - Метки с названиями топиков + обложки
///   - Вторая вкладка `MainTabBArController`
protocol LoadTopicsUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку топиков.
  /// - Returns: Возвращает результат типа `Result<[Topic], any Error>`,
  /// содержащий массив объектов `[Topic]` в случае успеха или ошибку в случае неудачи.
  func execute() async -> Result<[Topic], any Error>
}

// MARK: - Struct
struct LoadTopicsUseCase: LoadTopicsUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadTopicsPageRepositoryProtocol`,
  /// используемый для загрузки списка топиков (Шапка топиков без содержимого).
  let repository: any LoadTopicsPageRepositoryProtocol
  let requestController: any RequestControllerProtocol
  
  func execute() async -> Result<[Topic], any Error> {
    do {
      let request = try requestController.topicsTitleRequest()
      let topics = try await repository.fetchTopic(request: request)
      return .success(topics)
    } catch {
      return .failure(error)
    }
  }
}

