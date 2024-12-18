//
//  LoadAlbumPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки фотографий отдельно взятого альбома.
protocol LoadAlbumPhotosUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку фотографий.
  /// - Returns: Возвращает результат типа `Result<[Photo], any Error>`,
  /// содержащий массив объектов `[Photo]` в случае успеха или ошибку в случае неудачи.
  func execute() async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadAlbumPhotosUseCase: LoadAlbumPhotosUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadAlbumPhotosRepositoryProtocol`,
  /// используемый для загрузки списка фотографий отдельно взятого альбома.
  let repository: any LoadAlbumPhotosRepositoryProtocol
  let requestController: any RequestControllerProtocol
  let album: Album
  
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try requestController.albumPhotosRequest(album: album)
      let photos = try await repository.fetchAlbumPhotos(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
