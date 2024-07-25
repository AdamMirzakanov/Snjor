//
//  LoadPhotoListUseCase.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

protocol LoadPhotoListUseCaseProtocol {
  func execute() async -> Result<[Photo], any Error>
}

struct LoadPhotoListUseCase: LoadPhotoListUseCaseProtocol {
  // MARK: - Internal Properties
  let photoListRepository: any PhotoListRepositoryProtocol

  // MARK: - Internal Methods
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.photoListRequest()
      let photos = try await photoListRepository.fetchPhotoList(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}

