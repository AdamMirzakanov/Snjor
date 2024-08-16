//
//  LoadTopicPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

protocol LoadTopicPhotosUseCaseProtocol {
  func execute() async -> Result<[Photo], any Error>
}

struct LoadTopicPhotosUseCase: LoadTopicPhotosUseCaseProtocol {
  // MARK: - Internal Properties
  let repository: any LoadTopicPhotosRepositoryProtocol
  let topic: Topic
  
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.topicPhotosRequest(topic: topic)
      let photos = try await repository.fetchTopicsPhotoList(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
