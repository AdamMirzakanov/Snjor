////
////  TopicsPhotosUseCase.swift
////  Snjor
////
////  Created by Адам Мирзаканов on 23.07.2024.
////
//
//protocol TopicsPhotosUseCaseProtocol {
//  func execute() async -> Result<[Photo], any Error>
//}
//
//struct TopicsPhotosUseCase: TopicsPhotosUseCaseProtocol {
//  // MARK: - Internal Properties
//  let topicsPhotosRepository: any TopicsPhotosRepositoryProtocol
//
//  // MARK: - Internal Methods
//  func execute() async -> Result<[Photo], any Error> {
//    do {
//      let request = try RequestController.photoListRequest()
//      let photos = try await topicsPhotosRepository.fetchTopicsPhotos(request: request)
//      return .success(photos)
//    } catch {
//      return .failure(error)
//    }
//  }
//}
