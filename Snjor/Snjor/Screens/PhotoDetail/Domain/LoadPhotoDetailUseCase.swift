//
//  LoadPhotoDetailUseCase.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

protocol LoadPhotoDetailUseCaseProtocol {
  func execute() async throws -> Photo
}

struct LoadPhotoDetailUseCase: LoadPhotoDetailUseCaseProtocol {
  // MARK: - Private Properties
  let repository: any LoadPhotoDetailRepositoryProtocol
  let photo: Photo

  // MARK: - Internal Methods
  func execute() async throws -> Photo {
    let request = try RequestController.photoDetailRequest(photo: photo)
    return try await repository.fetchPhoto(request: request)
  }
}
