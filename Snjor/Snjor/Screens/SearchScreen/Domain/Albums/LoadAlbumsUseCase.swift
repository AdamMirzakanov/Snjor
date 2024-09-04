//
//  LoadAlbumsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

// MARK: - Protocol
protocol LoadAlbumsUseCaseProtocol {
  func execute() async -> Result<[Album], any Error>
}

// MARK: - Struct
struct LoadAlbumsUseCase: LoadAlbumsUseCaseProtocol {
  
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
