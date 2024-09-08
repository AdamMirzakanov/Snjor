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
      let searchAlbums = try await repository.fetchSearchAlbums(request: request)
      let albums = searchAlbums.results
      return .success(albums)
    } catch {
      return .failure(error)
    }
  }
}
