//
//  LoadTopicsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки списка топиков.
protocol LoadTopicsUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку топиков.
  /// - Returns: Возвращает результат типа `Result<[Topic], any Error>`,
  /// содержащий массив объектов `[Topic]` в случае успеха или ошибку в случае неудачи.
  func execute() async -> Result<[Topic], any Error>
}

// MARK: - Struct
/// Сценарий использования для загрузки списка тем.
/// Реализует протокол `LoadTopicsUseCaseProtocol`.
struct LoadTopicsUseCase: LoadTopicsUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadTopicsPageRepositoryProtocol`,
  /// используемый для загрузки тем.
  let repository: any LoadTopicsPageRepositoryProtocol
  
  func execute() async -> Result<[Topic], any Error> {
    do {
      let request = try RequestController.topicsTitleRequest()
      let topics = try await repository.fetchTopic(request: request)
      return .success(topics)
    } catch {
      return .failure(error)
    }
  }
}

