//
//  LoadUserLikedPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.09.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки фотографий лайкнутых пользователем.
protocol LoadUserLikedPhotosUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку фотографий лайкнутых пользователем.
  /// - Returns: Возвращает результат типа `Result<[Photo], any Error>`,
  /// содержащий массив объектов `[Photo]` в случае успеха или ошибку в случае неудачи.
  func execute() async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadUserLikedPhotosUseCase: LoadUserLikedPhotosUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadUserLikedPhotosRepositoryProtocol`,
  /// используемый для загрузки списка фотографий лайкнутых пользователем.
  let repository: any LoadUserLikedPhotosRepositoryProtocol
  let requestController: any RequestControllerProtocol
  let user: User
  
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try requestController.userLikedPhotosRequest(user: user)
      let photos = try await repository.fetchPhotos(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
