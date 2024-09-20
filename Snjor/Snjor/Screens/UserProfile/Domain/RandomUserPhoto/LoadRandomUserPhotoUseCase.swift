//
//  LoadRandomUserPhotoUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.09.2024.
//

// MARK: - Protocol
protocol LoadRandomUserPhotoUseCaseProtocol {
  func execute() async throws -> Photo
}

// MARK: - Struct
struct LoadRandomUserPhotoUseCase: LoadRandomUserPhotoUseCaseProtocol {
  let repository: any LoadRandomUserPhotoRepositoryProtocol
  let user: User
  
  func execute() async throws -> Photo {
    let request = try RequestController.randomUserPhotoRequest(user: user)
    return try await repository.fetchPhoto(request: request)
  }
}
