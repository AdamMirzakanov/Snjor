//
//  LoadTopicsPageRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadTopicsPageRepositoryProtocol {
  func fetchTopic(request: URLRequest) async throws -> [Topic]
}

// MARK: - Struct
struct LoadTopicsPageRepository: LoadTopicsPageRepositoryProtocol {
  let networkService: any Requestable

  func fetchTopic(request: URLRequest) async throws -> [Topic] {
    return try await networkService.request(
      request: request,
      type: [Topic].self
    )
  }
}
