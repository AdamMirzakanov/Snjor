//
//  LoadSearchAlbumsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки списка альбомов по поисковому запросу.
protocol LoadSearchAlbumsUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку альбомов.
  ///
  /// - Parameter searchTerm: Текст поискового запроса.
  /// - Returns: Возвращает результат типа `Result<[Album], any Error>`,
  /// содержащий массив объектов `[Album]` в случае успеха или ошибку в случае неудачи.
  func execute(with searchTerm: String) async -> Result<[Album], any Error>
}

// MARK: - Struct
struct LoadSearchAlbumsUseCase: LoadSearchAlbumsUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadSearchAlbumsRepositoryProtocol`,
  /// используемый для загрузки списка фотографий по поисковому запросу.
  let repository: any LoadSearchAlbumsRepositoryProtocol
  
  func execute(with searchTerm: String) async -> Result<[Album], any Error> {
    do {
      let request = try RequestController.searchAlbumsRequest(with: searchTerm)
      let searchAlbums = try await repository.fetchSearchAlbums(request: request)
      let albums = searchAlbums.results
      return .success(albums)
    } catch {
      return .failure(error)
    }
  }
}
