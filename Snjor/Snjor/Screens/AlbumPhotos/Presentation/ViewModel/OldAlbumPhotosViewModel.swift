//
//  OldAlbumPhotosViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import Combine

final class OldAlbumPhotosViewModel: OldAlbumPhotosViewModelProtocol {

  // MARK: - Internal Properties
  var state: PassthroughSubject<StateController, Never>
  var photos: [Photo] = []
  
  // MARK: - Private Properties
  private let loadUseCase: any LoadAlbumPhotosUseCaseProtocol
  private var lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadAlbumPhotosUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  ) {
    self.state = state
    self.loadUseCase = loadUseCase
    self.lastPageValidationUseCase = lastPageValidationUseCase
  }
  
  // MARK: - Internal Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
       await loadAlbumPhotosUseCase()
    }
  }
  
  func getPhoto(at index: Int) -> Photo {
    photos[index]
  }
  
  func getAlbumPhotosViewModelItem(at index: Int) -> OldPhotosViewModelItem {
    checkAndLoadMorePhotos(at: index)
    return makeAlbumPhotosViewModelItem(at: index)
  }
  
  func checkAndLoadMorePhotos(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: viewDidLoad
    )
  }
  
  func loadAlbumPhotosUseCase() async {
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
  
  private func makeAlbumPhotosViewModelItem(at index: Int) -> OldPhotosViewModelItem {
    let photo = photos[index]
    return OldPhotosViewModelItem(photo: photo)
  }
}
