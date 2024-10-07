//
//  LoadUserAlbumsUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

// MARK: - Protocol
protocol LoadUserAlbumsUseCaseProtocol {
  func execute() async -> Result<[Album], any Error>
}

// MARK: - Struct
struct LoadUserAlbumsUseCase: LoadUserAlbumsUseCaseProtocol {
  let repository: any LoadUserAlbumsRepositoryProtocol
  let user: User
  
  func execute() async -> Result<[Album], any Error> {
    do {
      let request = try RequestController.userAlbumsRequest(user: user)
      let albums = try await repository.fetchPhotos(request: request)
      return .success(albums)
    } catch {
      return .failure(error)
    }
  }
}
