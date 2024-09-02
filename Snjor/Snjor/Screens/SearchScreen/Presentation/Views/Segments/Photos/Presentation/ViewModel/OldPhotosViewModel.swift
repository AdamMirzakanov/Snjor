//
//  OldPhotosViewModel.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Combine

final class OldPhotosViewModel: OldPhotosViewModelProtocol {
  
  // MARK: - Internal Properties
  var photos: [Photo] = []
  
  // MARK: - Private Properties
  private let loadUseCase: any LoadPhotosUseCaseProtocol
  private let loadSearchPhotosUseCase: any LoadSearchPhotosUseCaseProtocol
  private(set) var state: PassthroughSubject<StateController, Never>
  private var lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadPhotosUseCaseProtocol,
    loadSearchPhotosUseCase: any LoadSearchPhotosUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  ) {
    self.state = state
    self.loadUseCase = loadUseCase
    self.loadSearchPhotosUseCase = loadSearchPhotosUseCase
    self.lastPageValidationUseCase = lastPageValidationUseCase
  }
  
  // MARK: - Internal Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadPhotosUseCase()
    }
  }
  
  func loadSearchPhotos(with searchTerm: String) {
    state.send(.loading)
    Task {
      await loadSearchPhotosUseCase(with: searchTerm)
    }
  }
  
  func getPhoto(at index: Int) -> Photo {
    photos[index]
  }
  
  func getPhotosViewModelItem(
    at index: Int
  ) -> OldPhotosViewModelItem {
    checkAndLoadMorePhotos(at: index)
    return makePhotosViewModelItem(at: index)
  }
  
  func getSearchPhotosViewModelItem(
    at index: Int,
    with searchTerm: String
  ) -> OldPhotosViewModelItem {
    checkAndLoadMoreSearchPhotos(at: index, with: searchTerm)
    return makeSearchPhotosViewModelItem(at: index)
  }
  
  func checkAndLoadMorePhotos(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: viewDidLoad
    )
  }
  
  func checkAndLoadMoreSearchPhotos(at index: Int, with searchTerm: String) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: { self.loadSearchPhotos(with: searchTerm) }
    )
  }
  
  // MARK: - Private Methods
  private func loadPhotosUseCase() async {
    let result = await loadUseCase.execute()
    updateStateUI(with: result)
  }
  
  private func loadSearchPhotosUseCase(with searchTerm: String) async {
    let result = await loadSearchPhotosUseCase.execute(with: searchTerm)
    updateStateUI(with: result)
  }
  
  private func makePhotosViewModelItem(at index: Int) -> OldPhotosViewModelItem {
    let photo = photos[index]
    return OldPhotosViewModelItem(photo: photo)
  }
  
  private func makeSearchPhotosViewModelItem(
    at index: Int
  ) -> OldPhotosViewModelItem {
    let photo = photos[index]
    return OldPhotosViewModelItem(photo: photo)
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
}
