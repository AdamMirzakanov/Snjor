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
  // MARK: - Internal Properties
  let apiClient: any Requestable

  // MARK: - Internal Methods
  func fetchPhoto(request: URLRequest) async throws -> Photo {
    let photo = try await apiClient.request(request: request, type: Photo.self)
    return photo
  }
}
