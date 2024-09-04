//
//  LoadSearchPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

// MARK: - Protocol
protocol LoadSearchPhotosUseCaseProtocol {
  func execute(with searchTerm: String) async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadSearchPhotosUseCase: LoadSearchPhotosUseCaseProtocol {
  
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
