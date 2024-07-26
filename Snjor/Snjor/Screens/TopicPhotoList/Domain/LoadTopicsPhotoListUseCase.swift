//
//  LoadTopicsPhotoListUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

protocol LoadTopicsPagePhotoListUseCaseProtocol {
  func execute() async -> Result<[Photo], any Error>
}

struct LoadTopicsPagePhotoListUseCase: LoadTopicsPagePhotoListUseCaseProtocol {
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
