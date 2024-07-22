//
//  LoadTopicsPageUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import Foundation

protocol LoadTopicsPageUseCaseProtocol {
  func execute() async -> Result<[Topic], any Error>
}

struct LoadTopicsPageUseCase: LoadTopicsPageUseCaseProtocol {
  // MARK: - Private Properties
  let topicsPageRepository: any TopicsPageRepositoryProtocol
  
  // MARK: - Internal Methods
  func execute() async -> Result<[Topic], any Error> {
    do {
      let request = try RequestController.topicsRequest()
      let topics = try await topicsPageRepository.fetchTopic(request: request)
      return .success(topics)
    } catch {
      return .failure(error)
    }
  }
}
