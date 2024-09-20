//
//  LoadRandomUserPhotoRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.09.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadRandomUserPhotoRepositoryProtocol {
  func fetchPhoto(request: URLRequest) async throws -> Photo
}

// MARK: - Struct
struct LoadRandomUserPhotoRepository: LoadRandomUserPhotoRepositoryProtocol {
  let networkService: any Requestable
  
  func fetchPhoto(request: URLRequest) async throws -> Photo {
    return try await networkService.request(
      request: request,
      type: Photo.self
    )
  }
}
