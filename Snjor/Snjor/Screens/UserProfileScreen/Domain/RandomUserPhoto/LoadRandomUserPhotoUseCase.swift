//
//  LoadRandomUserPhotoUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.09.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки случайной фотографии
protocol LoadRandomUserPhotoUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку случайной фотографии.
  /// - Returns: Возвращает объект типа `Photo`.
  func execute() async throws -> Photo
}

// MARK: - Struct
struct LoadRandomUserPhotoUseCase: LoadRandomUserPhotoUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadRandomUserPhotoRepositoryProtocol`,
  /// используемый для загрузки случайной фотографии
  let repository: any LoadRandomUserPhotoRepositoryProtocol
  let requestController: any RequestControllerProtocol
  let user: User
  
  func execute() async throws -> Photo {
    let request = try requestController.randomUserPhotoRequest(user: user)
    return try await repository.fetchPhoto(request: request)
  }
}
