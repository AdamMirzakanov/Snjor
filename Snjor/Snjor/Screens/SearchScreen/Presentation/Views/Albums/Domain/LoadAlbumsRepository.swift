//
//  LoadAlbumsRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import Foundation

protocol LoadAlbumsRepositoryProtocol {
  func fetchAlbumList(request: URLRequest) async throws -> [Album]
}

struct LoadAlbumsRepository: LoadAlbumsRepositoryProtocol {
  // MARK: - Internal Properties
  let networkService: any Requestable

  // MARK: - Internal Methods
  func fetchAlbumList(request: URLRequest) async throws -> [Album] {
    return try await networkService.request(request: request, type: [Album].self)
  }
}
