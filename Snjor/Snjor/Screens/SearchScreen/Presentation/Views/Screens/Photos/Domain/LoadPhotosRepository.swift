//
//  LoadPhotosRepository.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Foundation

protocol LoadPhotosRepositoryProtocol {
  func fetchPhotoList(request: URLRequest) async throws -> [Photo]
}

struct LoadPhotosRepository: LoadPhotosRepositoryProtocol {
  // MARK: - Internal Properties
  let networkService: any Requestable

  // MARK: - Internal Methods
  func fetchPhotoList(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
