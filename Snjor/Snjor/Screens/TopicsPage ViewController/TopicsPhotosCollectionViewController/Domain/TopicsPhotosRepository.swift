////
////  TopicsPhotosRepository.swift
////  Snjor
////
////  Created by Адам Мирзаканов on 23.07.2024.
////
//
//import Foundation
//
//protocol TopicsPhotosRepositoryProtocol {
//  func fetchTopicsPhotos(request: URLRequest) async throws -> [Photo]
//}
//
//struct TopicsPhotosRepository: TopicsPhotosRepositoryProtocol {
//  // MARK: - Internal Properties
//  let apiClient: any Requestable
//  
//  // MARK: - Internal Methods
//  func fetchTopicsPhotos(request: URLRequest) async throws -> [Photo] {
//    return try await apiClient.request(
//      request: request,
//      type: [Photo].self
//    )
//  }
//}
