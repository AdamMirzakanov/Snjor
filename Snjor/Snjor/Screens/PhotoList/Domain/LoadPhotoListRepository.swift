//
//  LoadPhotoListRepository.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Foundation

protocol PhotoListRepositoryProtocol {
  func fetchPhotoList(request: URLRequest) async throws -> [Photo]
}

struct PhotoListRepository: PhotoListRepositoryProtocol {
  // MARK: - Internal Properties
  let apiClient: any Requestable

  // MARK: - Internal Methods
  func fetchPhotoList(request: URLRequest) async throws -> [Photo] {
    return try await apiClient.request(
      request: request,
      type: [Photo].self
    )
  }
}
