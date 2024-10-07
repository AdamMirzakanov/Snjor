//
//  LoadAlbumPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

// MARK: - Protocol
protocol LoadAlbumPhotosUseCaseProtocol {
  func execute() async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadAlbumPhotosUseCase: LoadAlbumPhotosUseCaseProtocol {
  let repository: any LoadAlbumPhotosRepositoryProtocol
  let album: Album
  
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.albumPhotosRequest(album: album)
      let photos = try await repository.fetchAlbumPhotos(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
