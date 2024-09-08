//
//  LoadSearchUsersRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadSearchUsersRepositoryProtocol {
  func fetchSearchUsers(request: URLRequest) async throws -> SearchUsers
}

// MARK: - Struct
struct LoadSearchUsersRepository: LoadSearchUsersRepositoryProtocol {
  let networkService: any Requestable
  
  func fetchSearchUsers(request: URLRequest) async throws -> SearchUsers {
    return try await networkService.request(
      request: request,
      type: SearchUsers.self
    )
  }
}
