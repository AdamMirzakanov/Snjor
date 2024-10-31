//
//  LoadPhotosUseCase.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки списка фотографий в сегменте Discover.
protocol LoadPhotosUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку фотографий.
  /// - Returns: Возвращает результат типа `Result<[Photo], any Error>`,
  /// содержащий массив объектов `[Photo]` в случае успеха или ошибку в случае неудачи.
  func execute() async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadPhotosUseCase: LoadPhotosUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadPhotosRepositoryProtocol`,
  /// используемый для загрузки списка фотографий в сегменте Discover.
  let repository: any LoadPhotosRepositoryProtocol

  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.photosRequest()
      let photos = try await repository.fetchPhotos(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
