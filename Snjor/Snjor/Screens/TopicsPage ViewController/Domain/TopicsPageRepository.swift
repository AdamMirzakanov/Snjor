//
//  TopicsPageRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import Foundation

protocol TopicsPageRepositoryProtocol {
  func fetchTopic(request: URLRequest) async throws -> [Topic]
}

struct TopicsPageRepository: TopicsPageRepositoryProtocol {
  // MARK: - Internal Properties
  let apiClient: any Requestable

  // MARK: - Internal Methods
  func fetchTopic(request: URLRequest) async throws -> [Topic] {
    return try await apiClient.request(
      request: request,
      type: [Topic].self
    )
  }
}
