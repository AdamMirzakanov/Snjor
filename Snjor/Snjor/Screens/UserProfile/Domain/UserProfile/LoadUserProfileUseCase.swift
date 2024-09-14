//
//  LoadUserProfileUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

// MARK: - Protocol
protocol LoadUserProfileUseCaseProtocol {
  func execute() async throws -> User
}

// MARK: - Struct
struct LoadUserProfileUseCase: LoadUserProfileUseCaseProtocol {
  let repository: any LoadUserProfileRepositoryProtocol
  let user: User
  
  func execute() async throws -> User {
    let request = try RequestController.userProfileRequest(user: user)
    return try await repository.fetchUser(request: request)
  }
}
