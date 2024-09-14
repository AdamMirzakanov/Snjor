//
//  LoadUserLikedPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.09.2024.
//

// MARK: - Protocol
protocol LoadUserLikedPhotosUseCaseProtocol {
  func execute() async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadUserLikedPhotosUseCase: LoadUserLikedPhotosUseCaseProtocol {
  let repository: any LoadUserLikedPhotosRepositoryProtocol
  let user: User
  
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.userLikedPhotosRequest(user: user)
      let photos = try await repository.fetchPhotos(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
