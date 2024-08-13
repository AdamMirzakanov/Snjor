//
//  LoadPhotosUseCase.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

protocol LoadPhotosUseCaseProtocol {
  func execute() async -> Result<[Photo], any Error>
}

struct LoadPhotosUseCase: LoadPhotosUseCaseProtocol {
  // MARK: - Internal Properties
  let repository: any LoadPhotosRepositoryProtocol

  // MARK: - Internal Methods
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.photosRequest()
      let photos = try await repository.fetchPhotoList(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
