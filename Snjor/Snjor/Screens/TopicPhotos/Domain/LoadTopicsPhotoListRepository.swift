//
//  LoadTopicPhotosRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadTopicPhotosRepositoryProtocol {
  func fetchTopicsPhotoList(request: URLRequest) async throws -> [Photo]
}

// MARK: - Struct
struct LoadTopicPhotosRepository: LoadTopicPhotosRepositoryProtocol {
  let networkService: any Requestable
  
  func fetchTopicsPhotoList(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
