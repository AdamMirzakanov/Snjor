//
//  LoadAlbumPhotosRepositoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import Foundation

protocol LoadAlbumPhotosRepositoryProtocol {
  func fetchAlbumPhotos(request: URLRequest) async throws -> [Photo]
}

struct LoadAlbumPhotosRepository: LoadAlbumPhotosRepositoryProtocol {
  let networkService: any Requestable
  
  func fetchAlbumPhotos(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
