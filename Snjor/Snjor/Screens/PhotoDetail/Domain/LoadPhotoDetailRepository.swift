//
//  LoadPhotoDetailRepository.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation

protocol LoadPhotoDetailRepositoryProtocol {
  func fetchPhoto(request: URLRequest) async throws -> Photo
}

struct LoadPhotoDetailRepository: LoadPhotoDetailRepositoryProtocol {
  // MARK: - Internal Properties
  let networkService: any Requestable

  // MARK: - Internal Methods
  func fetchPhoto(request: URLRequest) async throws -> Photo {
    return try await networkService.request(
      request: request,
      type: Photo.self
    )
  }
}
