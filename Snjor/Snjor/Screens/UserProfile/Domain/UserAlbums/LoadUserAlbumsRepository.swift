//
//  LoadUserAlbumsRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import Foundation

// MARK: - Protocol
protocol LoadUserAlbumsRepositoryProtocol {
  func fetchPhotos(request: URLRequest) async throws -> [Album]
}

// MARK: - Struct
struct LoadUserAlbumsRepository: LoadUserAlbumsRepositoryProtocol {
  let networkService: any Requestable
  
  func fetchPhotos(request: URLRequest) async throws -> [Album] {
    return try await networkService.request(
      request: request,
      type: [Album].self
    )
  }
}
