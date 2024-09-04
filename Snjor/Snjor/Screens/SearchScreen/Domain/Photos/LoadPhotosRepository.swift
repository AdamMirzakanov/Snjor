//
//  LoadPhotosRepository.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadPhotosRepositoryProtocol {
  func fetchPhotoList(request: URLRequest) async throws -> [Photo]
}

// MARK: - Struct
struct LoadPhotosRepository: LoadPhotosRepositoryProtocol {
  
  let networkService: any Requestable

  func fetchPhotoList(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
