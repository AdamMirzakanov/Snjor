//
//  LoadSearchPhotosRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

import Foundation

protocol LoadSearchPhotosRepositoryProtocol {
  func fetchSearchPhotos(request: URLRequest) async throws -> SearchPhotos
}

struct LoadSearchPhotosRepository: LoadSearchPhotosRepositoryProtocol {
  // MARK: - Internal Properties
  let networkService: any Requestable
  
  // MARK: - Internal Methods
  func fetchSearchPhotos(request: URLRequest) async throws -> SearchPhotos {
    return try await networkService.request(
      request: request,
      type: SearchPhotos.self
    )
  }
}
