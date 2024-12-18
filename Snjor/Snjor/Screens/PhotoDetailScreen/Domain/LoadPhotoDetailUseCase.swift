//
//  LoadPhotoDetailUseCase.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку деталей о
/// фотографии а так же и самой фотографии (при надобности).
protocol LoadPhotoDetailUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку деталей о фотографии.
  /// - Returns: Возвращает объект типа `Photo`.
  func execute() async throws -> Photo
}

// MARK: - Struct
struct LoadPhotoDetailUseCase: LoadPhotoDetailUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadPhotoDetailRepositoryProtocol`,
  /// используемый для за загрузку деталей о фотографии
  let repository: any LoadPhotoDetailRepositoryProtocol
  let requestController: any RequestControllerProtocol
  let photo: Photo

  func execute() async throws -> Photo {
    let request = try requestController.photoDetailRequest(photo: photo)
    return try await repository.fetchPhoto(request: request)
  }
}
