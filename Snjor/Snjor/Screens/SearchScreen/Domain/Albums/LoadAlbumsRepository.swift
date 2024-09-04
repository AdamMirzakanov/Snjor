//
//  LoadAlbumsRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadAlbumsRepositoryProtocol {
  func fetchAlbumList(request: URLRequest) async throws -> [Album]
}

// MARK: - Struct
struct LoadAlbumsRepository: LoadAlbumsRepositoryProtocol {
  
  let networkService: any Requestable

  func fetchAlbumList(request: URLRequest) async throws -> [Album] {
    return try await networkService.request(request: request, type: [Album].self)
  }
}
