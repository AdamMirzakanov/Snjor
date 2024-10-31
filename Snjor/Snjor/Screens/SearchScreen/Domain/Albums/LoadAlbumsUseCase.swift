//
//  LoadAlbumsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки альбомов в сегменте Topic & Albums.
protocol LoadAlbumsUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку альбомов.
  /// - Returns: Возвращает результат типа `Result<[Album], any Error>`,
  /// содержащий массив объектов `[Album]` в случае успеха или ошибку в случае неудачи.
  func execute() async -> Result<[Album], any Error>
}

// MARK: - Struct
struct LoadAlbumsUseCase: LoadAlbumsUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadAlbumsRepositoryProtocol`,
  /// используемый для загрузки списка альбомов в сегменте Topic & Albums.
  let repository: any LoadAlbumsRepositoryProtocol
  
  func execute() async -> Result<[Album], any Error> {
    do {
      let request = try RequestController.albumsRequest()
      let albums = try await repository.fetchAlbumList(request: request)
      return .success(albums)
    } catch {
      return .failure(error)
    }
  }
}
