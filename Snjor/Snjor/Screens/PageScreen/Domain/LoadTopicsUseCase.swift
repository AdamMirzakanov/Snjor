//
//  LoadTopicsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadTopicsUseCaseProtocol {
  func execute() async -> Result<[Topic], any Error>
}

// MARK: - Struct
struct LoadTopicsUseCase: LoadTopicsUseCaseProtocol {
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
