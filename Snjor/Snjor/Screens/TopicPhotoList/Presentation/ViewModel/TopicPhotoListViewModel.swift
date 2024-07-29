//
//  TopicPhotoListViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

final class TopicPhotoListViewModel: TopicPhotoListViewModelProtocol {
  
  // MARK: - Internal Properties
  var photosCount: Int { photos.count }
  var state: PassthroughSubject<StateController, Never>
  var snapshot: NSDiffableDataSourceSnapshot<Section, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(photos)
    return snapshot
  }
  
  // MARK: - Private Properties
  private let loadUseCase: any LoadTopicsPagePhotoListUseCaseProtocol
  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  private var photos: [Photo] = []
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadTopicsPagePhotoListUseCaseProtocol,
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
  
  func getPhoto(at indexPath: Int) -> Photo {
    photos[indexPath]
  }
  
  func getTopicPhotoListViewModelItem(at index: Int) -> TopicPhotoListViewModelItem {
    checkAndLoadMorePhotos(at: index)
    return makeTopicPhotoListViewModelItem(at: index)
  }
  
  // MARK: - Private Methods
  private func checkAndLoadMorePhotos(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: viewDidLoad
    )
  }
  
  private func loadTopicsPagePhotoListUseCase() async {
    let result = await loadUseCase.execute()
    updateStateUI(with: result)
  }
  
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
  
  func makeTopicPhotoListViewModelItem(at index: Int) -> TopicPhotoListViewModelItem {
    let photo = photos[index]
    return TopicPhotoListViewModelItem(photo: photo)
  }
}

// MARK: - Section
enum Section: CaseIterable {
  case main
}
