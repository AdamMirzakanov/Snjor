//
//  PhotoDetailRepository.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation

protocol PhotoDetailRepositoryProtocol {
  func fetchPhoto(request: URLRequest) async throws -> Photo
}

struct PhotoDetailRepository: PhotoDetailRepositoryProtocol {
  // MARK: - Public Properties
  let apiClient: any Requestable

  // MARK: - Public Methods
  func fetchPhoto(request: URLRequest) async throws -> Photo {
    return try await apiClient.request(request: request, type: Photo.self)
  }
}
