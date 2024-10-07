//
//  LoadUserPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.09.2024.
//

// MARK: - Protocol
protocol LoadUserPhotosUseCaseProtocol {
  func execute() async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadUserPhotosUseCase: LoadUserPhotosUseCaseProtocol {
  let repository: any LoadUserPhotosRepositoryProtocol
  let user: User
  
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.userPhotosRequest(user: user)
      let photos = try await repository.fetchPhotos(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
