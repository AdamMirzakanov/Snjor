//
//  LoadUserProfileRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadUserProfileRepositoryProtocol {
  func fetchUser(request: URLRequest) async throws -> User
}


// MARK: - Struct
struct LoadUserProfileRepository: LoadUserProfileRepositoryProtocol {
  let networkService: any Requestable
  
  func fetchUser(request: URLRequest) async throws -> User {
    return try await networkService.request(
      request: request,
      type: User.self
    )
  }
}
