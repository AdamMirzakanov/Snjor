//
//  LoadAlbumListUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

protocol LoadAlbumListUseCaseProtocol {
  func execute() async -> Result<[Album], any Error>
}

struct LoadAlbumListUseCase: LoadAlbumListUseCaseProtocol {
  // MARK: - Internal Properties
  let repository: any LoadAlbumListRepositoryProtocol
  
  // MARK: - Internal Methods
  func execute() async -> Result<[Album], any Error> {
    do {
      let request = try RequestController.albumListRequest()
      let albums = try await repository.fetchAlbumList(request: request)
      return .success(albums)
    } catch {
      return .failure(error)
    }
  }
}
