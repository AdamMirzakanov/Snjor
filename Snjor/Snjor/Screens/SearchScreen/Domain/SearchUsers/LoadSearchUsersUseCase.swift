//
//  LoadSearchUsersUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки списка юзеров по поисковому запросу.
protocol LoadSearchUsersUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку фотографий.
  ///
  /// - Parameter searchTerm: Текст поискового запроса.
  /// - Returns: Возвращает результат типа `Result<[User], any Error>`,
  /// содержащий массив объектов `[User]` в случае успеха или ошибку в случае неудачи.
  func execute(with searchTerm: String) async -> Result<[User], any Error>
}

// MARK: - Struct
struct LoadSearchUsersUseCase: LoadSearchUsersUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadSearchUsersRepositoryProtocol`,
  /// используемый для загрузки списка фотографий по поисковому запросу.
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
