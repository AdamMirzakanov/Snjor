//
//  LoadPhotosUseCase.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

// MARK: - Protocol
protocol LoadPhotosUseCaseProtocol {
  func execute() async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadPhotosUseCase: LoadPhotosUseCaseProtocol {
  
  let repository: any LoadPhotosRepositoryProtocol

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
