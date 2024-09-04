//
//  LoadSearchAlbumsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

// MARK: - Protocol
protocol LoadSearchAlbumsUseCaseProtocol {
  func execute(with searchTerm: String) async -> Result<[Album], any Error>
}

// MARK: - Struct
struct LoadSearchAlbumsUseCase: LoadSearchAlbumsUseCaseProtocol {
  
  let repository: any LoadSearchAlbumsRepositoryProtocol
  
  func execute(with searchTerm: String) async -> Result<[Album], any Error> {
    do {
      let request = try RequestController.searchAlbumsRequest(with: searchTerm)
      let searchPhotos = try await repository.fetchSearchAlbums(request: request)
      let photos = searchPhotos.results
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
