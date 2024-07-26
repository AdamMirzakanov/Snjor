//
//  LoadTopicsPhotoListRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import Foundation

protocol LoadPageTopicsPhotoListRepositoryProtocol {
  func fetchTopicsPhotoList(request: URLRequest) async throws -> [Photo]
}

struct LoadPageTopicsPhotoListRepository: LoadPageTopicsPhotoListRepositoryProtocol {
  // MARK: - Internal Properties
  let networkService: any Requestable
  
  // MARK: - Internal Methods
  func fetchTopicsPhotoList(request: URLRequest) async throws -> [Photo] {
    return try await networkService.request(
      request: request,
      type: [Photo].self
    )
  }
}
