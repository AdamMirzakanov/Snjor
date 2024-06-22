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
  // MARK: - Private Properties
  let photoListRepository: any PhotoListRepositoryProtocol

  // MARK: - Public Methods
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.photoListURLRequest()
      let photos = try await photoListRepository.fetchPhotoList(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
