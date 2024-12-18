//
//  LoadUserAlbumsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки альбомов пользователя.
protocol LoadUserAlbumsUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку альбомов пользователя.
  /// - Returns: Возвращает результат типа `Result<[Album], any Error>`,
  /// содержащий массив объектов `[Album]` в случае успеха или ошибку в случае неудачи.
  func execute() async -> Result<[Album], any Error>
}

// MARK: - Struct
struct LoadUserAlbumsUseCase: LoadUserAlbumsUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadUserAlbumsRepositoryProtocol`,
  /// используемый для загрузки списка альбомов пользователя.
  let repository: any LoadUserAlbumsRepositoryProtocol
  let requestController: any RequestControllerProtocol
  let user: User
  
  func execute() async -> Result<[Album], any Error> {
    do {
      let request = try requestController.userAlbumsRequest(user: user)
      let albums = try await repository.fetchPhotos(request: request)
      return .success(albums)
    } catch {
      return .failure(error)
    }
  }
}
