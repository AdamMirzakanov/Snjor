//
//  LoadUserLikedPhotosRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.09.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadUserLikedPhotosRepositoryProtocol {
  func fetchPhotos(request: URLRequest) async throws -> [Photo]
}

// MARK: - Struct
struct LoadUserLikedPhotosRepository: LoadUserLikedPhotosRepositoryProtocol {
  let networkService: any Requestable
  
  func fetchPhotos(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
