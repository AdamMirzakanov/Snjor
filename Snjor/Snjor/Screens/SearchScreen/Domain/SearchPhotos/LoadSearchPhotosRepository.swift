//
//  LoadSearchPhotosRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadSearchPhotosRepositoryProtocol {
  func fetchSearchPhotos(request: URLRequest) async throws -> SearchPhotos
}

// MARK: - Struct
struct LoadSearchPhotosRepository: LoadSearchPhotosRepositoryProtocol {
  
  let networkService: any Requestable
  
  func fetchSearchPhotos(request: URLRequest) async throws -> SearchPhotos {
    return try await networkService.request(
      request: request,
      type: SearchPhotos.self
    )
  }
}
