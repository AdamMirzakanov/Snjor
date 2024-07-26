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
  let repository: any LoadPhotoListRepositoryProtocol

  // MARK: - Internal Methods
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.photoListRequest()
      let photos = try await repository.fetchPhotoList(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}

