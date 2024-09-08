//
//  LoadSearchUsersUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

// MARK: - Protocol
protocol LoadSearchUsersUseCaseProtocol {
  func execute(with searchTerm: String) async -> Result<[User], any Error>
}

// MARK: - Struct
struct LoadSearchUsersUseCase: LoadSearchUsersUseCaseProtocol {
  let repository: any LoadSearchUsersRepositoryProtocol
  
  func execute(with searchTerm: String) async -> Result<[User], any Error> {
    do {
      let request = try RequestController.searchUsersRequest(with: searchTerm)
      let searchUsers = try await repository.fetchSearchUsers(request: request)
      let users = searchUsers.results
      return .success(users)
    } catch {
      return .failure(error)
    }
  }
}
