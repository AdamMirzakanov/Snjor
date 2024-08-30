//
//  LoadSearchAlbumsRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

import Foundation

protocol LoadSearchAlbumsRepositoryProtocol {
  func fetchSearchAlbums(request: URLRequest) async throws -> SearchAlbums
}

struct LoadSearchAlbumsRepository: LoadSearchAlbumsRepositoryProtocol {
  // MARK: - Internal Properties
  let networkService: any Requestable
  
  // MARK: - Internal Methods
  func fetchSearchAlbums(request: URLRequest) async throws -> SearchAlbums {
    return try await networkService.request(
      request: request,
      type: SearchAlbums.self
    )
  }
}
