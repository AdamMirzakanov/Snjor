//
//  LoadPhotoDetailRepository.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadPhotoDetailRepositoryProtocol {
  func fetchPhoto(request: URLRequest) async throws -> Photo
}

// MARK: - Struct
struct LoadPhotoDetailRepository: LoadPhotoDetailRepositoryProtocol {
  let networkService: any Requestable

  func fetchPhoto(request: URLRequest) async throws -> Photo {
    return try await networkService.request(
      request: request,
      type: Photo.self
    )
  }
}
