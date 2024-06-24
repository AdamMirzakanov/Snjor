//
//  LoadPhotoDetailUseCase.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation

protocol LoadPhotoDetailUseCaseProtocol {
  func execute() async -> Result<Photo, any Error>
}

struct LoadPhotoDetailUseCase: LoadPhotoDetailUseCaseProtocol {
  // MARK: - Private Properties
  let photoDetailRepository: any PhotoDetailRepositoryProtocol
  let photo: Photo

  // MARK: - Public Methods
  func execute() async -> Result<Photo, any Error> {
    do {
      let request = try RequestController.photoRequest(id: photo.id)
      let photo = try await photoDetailRepository.fetchPhoto(request: request)
      return .success(photo)
    } catch {
      return .failure(error)
    }
  }
}
