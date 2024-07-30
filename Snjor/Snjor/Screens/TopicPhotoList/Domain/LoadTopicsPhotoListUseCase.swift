//
//  LoadTopicsPhotoListUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

protocol LoadTopicPhotoListUseCaseProtocol {
  func execute() async -> Result<[Photo], any Error>
}

struct LoadTopicPhotoListUseCase: LoadTopicPhotoListUseCaseProtocol {
  // MARK: - Internal Properties
  let repository: any LoadPageTopicsPhotoListRepositoryProtocol
  let topic: Topic
  
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.topicsPhotoListRequest(topic: topic)
      let photos = try await repository.fetchTopicsPhotoList(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
