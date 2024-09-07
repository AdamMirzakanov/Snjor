//
//  LoadPhotoDetailUseCase.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

// MARK: - Protocol
protocol LoadPhotoDetailUseCaseProtocol {
  func execute() async throws -> Photo
}

// MARK: - Struct
struct LoadPhotoDetailUseCase: LoadPhotoDetailUseCaseProtocol {
  let repository: any LoadPhotoDetailRepositoryProtocol
  let photo: Photo

  func execute() async throws -> Photo {
    let request = try RequestController.photoDetailRequest(photo: photo)
    return try await repository.fetchPhoto(request: request)
  }
}
