//
//  LoadUserProfileUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки даннных о пользователе.
protocol LoadUserProfileUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку данных о пользователе.
  /// - Returns: Возвращает объект типа `User`.
  func execute() async throws -> User
}

// MARK: - Struct
struct LoadUserProfileUseCase: LoadUserProfileUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadUserProfileRepositoryProtocol`,
  /// используемый для загрузки данных о пользователе.
  let repository: any LoadUserProfileRepositoryProtocol
  let requestController: any RequestControllerProtocol
  let user: User
  
  func execute() async throws -> User {
    let request = try requestController.userProfileRequest(user: user)
    return try await repository.fetchUser(request: request)
  }
}
