//
//  LoadUserPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.09.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки фотографий пользователя.
protocol LoadUserPhotosUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку фотографий пользователя.
  /// - Returns: Возвращает результат типа `Result<[Photo], any Error>`,
  /// содержащий массив объектов `[Photo]` в случае успеха или ошибку в случае неудачи.
  func execute() async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadUserPhotosUseCase: LoadUserPhotosUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadUserPhotosRepositoryProtocol`,
  /// используемый для загрузки списка фотографий пользователя.
  let repository: any LoadUserPhotosRepositoryProtocol
  let requestController: any RequestControllerProtocol
  let user: User
  
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try requestController.userPhotosRequest(user: user)
      let photos = try await repository.fetchPhotos(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
