//
//  LoadSearchPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

protocol LoadSearchPhotosUseCaseProtocol {
  func execute(with searchTerm: String) async -> Result<[Photo], any Error>
}

struct LoadSearchPhotosUseCase: LoadSearchPhotosUseCaseProtocol {
  // MARK: - Internal Properties
  let repository: any LoadSearchPhotosRepositoryProtocol
  
  // MARK: - Internal Methods
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
