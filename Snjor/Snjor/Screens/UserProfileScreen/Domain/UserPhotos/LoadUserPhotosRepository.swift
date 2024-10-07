//
//  LoadUserPhotosRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.09.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadUserPhotosRepositoryProtocol {
  func fetchPhotos(request: URLRequest) async throws -> [Photo]
}

// MARK: - Struct
struct LoadUserPhotosRepository: LoadUserPhotosRepositoryProtocol {
  let networkService: any Requestable
  
  func fetchPhotos(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
