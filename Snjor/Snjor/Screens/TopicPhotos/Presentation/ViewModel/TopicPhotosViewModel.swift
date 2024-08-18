//
//  TopicPhotosViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import Combine

final class TopicPhotosViewModel: TopicPhotosViewModelProtocol {
  
  // MARK: - Internal Properties
  var state: PassthroughSubject<StateController, Never>
  var photos: [Photo] = []
  
  // MARK: - Private Properties
  private let loadUseCase: any LoadTopicPhotosUseCaseProtocol
  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadTopicPhotosUseCaseProtocol,
    lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  ) {
    self.state = state
    self.loadUseCase = loadUseCase
    self.lastPageValidationUseCase = lastPageValidationUseCase
  }
  
  // MARK: - Internal Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadTopicsPagePhotoListUseCase()
    }
  }
  
  func getPhoto(at index: Int) -> Photo {
    photos[index]
  }
  
  func getTopicPhotoListViewModelItem(
    at index: Int
  ) -> TopicPhotosViewModelItem {
    checkAndLoadMorePhotos(at: index)
    return makeTopicPhotoListViewModelItem(at: index)
  }
  
  func checkAndLoadMorePhotos(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: viewDidLoad
    )
  }
  
  func loadTopicsPagePhotoListUseCase() async {
    let result = await loadUseCase.execute()
    updateStateUI(with: result)
  }
  
  // MARK: - Private Methods
  private func updateStateUI(with result: Result<[Photo], Error>) {
    switch result {
    case .success(let photos):
      let existingPhotoIDs = self.photos.map { $0.id }
      let newPhotos = photos.filter { !existingPhotoIDs.contains($0.id) }
      lastPageValidationUseCase.updateLastPage(itemsCount: photos.count)
      self.photos.append(contentsOf: newPhotos)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
  
  private func makeTopicPhotoListViewModelItem(
    at index: Int
  ) -> TopicPhotosViewModelItem {
    let photo = photos[index]
    return TopicPhotosViewModelItem(photo: photo)
  }
}
