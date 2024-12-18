//
//  LoadPhotoDetailRepository.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку деталей о
/// фотографии а так же и самой фотографии (при надобности).
///
/// - Note: Фотография которая отображается в `PhotoDetailViewController`
/// передается из ячейки, однако полная информация о фотографии подгружается отдельно,
/// ввиду того что информация о фотографиях предоставляемая в ячейках ограничена хостингом.
protocol LoadPhotoDetailRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку деталей о фотографии.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает объект типа `Photo`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchPhoto(request: URLRequest) async throws -> Photo
}

// MARK: - Struct
struct LoadPhotoDetailRepository: LoadPhotoDetailRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any NetworkServiceProtocol

  func fetchPhoto(request: URLRequest) async throws -> Photo {
    return try await networkService.request(
      request: request,
      type: Photo.self
    )
  }
}
