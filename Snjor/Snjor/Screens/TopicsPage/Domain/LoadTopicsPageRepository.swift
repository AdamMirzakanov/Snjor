//
//  LoadTopicsPageRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import Foundation

protocol LoadTopicsPageRepositoryProtocol {
  func fetchTopic(request: URLRequest) async throws -> [Topic]
}

struct LoadTopicsPageRepository: LoadTopicsPageRepositoryProtocol {
  // MARK: - Internal Properties
  let networkService: any Requestable

  // MARK: - Internal Methods
  func fetchTopic(request: URLRequest) async throws -> [Topic] {
    return try await networkService.request(
      request: request,
      type: [Topic].self
    )
  }
}
