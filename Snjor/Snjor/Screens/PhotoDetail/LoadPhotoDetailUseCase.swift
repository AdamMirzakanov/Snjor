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

  // MARK: - Public Methods
  func execute() async -> Result<Photo, any Error> {
    do {// ⁉️⁉️⁉️
      let request = try RequestController.photosURLRequest()
      let photo = try await photoDetailRepository.fetchPhoto(request: request)
      return .success(photo)
    } catch {
      return .failure(error)
    }
  }

}
