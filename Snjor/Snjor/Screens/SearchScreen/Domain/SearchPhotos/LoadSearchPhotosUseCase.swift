//
//  LoadSearchPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки списка фотографий по поисковому запросу.
protocol LoadSearchPhotosUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку фотографий.
  ///
  /// - Parameter searchTerm: Текст поискового запроса.
  /// - Returns: Возвращает результат типа `Result<[Photo], any Error>`,
  /// содержащий массив объектов `[Photo]` в случае успеха или ошибку в случае неудачи.
  func execute(with searchTerm: String) async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadSearchPhotosUseCase: LoadSearchPhotosUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadSearchPhotosRepositoryProtocol`,
  /// используемый для загрузки списка фотографий по поисковому запросу.
  let repository: any LoadSearchPhotosRepositoryProtocol
  
  func execute(with searchTerm: String) async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.searchPhotosRequest(with: searchTerm)
      let searchPhotos = try await repository.fetchSearchPhotos(request: request)
      let photos = searchPhotos.results
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
