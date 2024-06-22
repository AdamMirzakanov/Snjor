//
//  LoadPhotoDetailUseCase.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation

protocol LoadPhotoDetailUseCaseProtocol {
  func execute() async throws -> Photo
}

struct LoadPhotoDetailUseCase: LoadPhotoDetailUseCaseProtocol {
  // MARK: - Private Properties
  let photoDetailRepository: any PhotoDetailRepositoryProtocol
  var urlDetail: URL

  // MARK: - Public Methods
  func execute() async throws -> Photo {
    let request = URLRequest(url: urlDetail)
    return try await photoDetailRepository.fetchPhoto(request: request)
  }
}
