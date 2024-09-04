//
//  LoadSearchAlbumsRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadSearchAlbumsRepositoryProtocol {
  func fetchSearchAlbums(request: URLRequest) async throws -> SearchAlbums
}

// MARK: - Struct
struct LoadSearchAlbumsRepository: LoadSearchAlbumsRepositoryProtocol {
  
  let networkService: any Requestable
  
  func fetchSearchAlbums(request: URLRequest) async throws -> SearchAlbums {
    return try await networkService.request(
      request: request,
      type: SearchAlbums.self
    )
  }
}
