//
//  LoadAlbumsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

protocol LoadAlbumsUseCaseProtocol {
  func execute() async -> Result<[Album], any Error>
}

struct LoadAlbumsUseCase: LoadAlbumsUseCaseProtocol {
  // MARK: - Internal Properties
  let repository: any LoadAlbumsRepositoryProtocol
  
  // MARK: - Internal Methods
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
