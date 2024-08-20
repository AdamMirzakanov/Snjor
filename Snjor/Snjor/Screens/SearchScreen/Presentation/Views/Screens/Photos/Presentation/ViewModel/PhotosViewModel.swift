//
//  PhotosViewModel.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Combine

final class PhotosViewModel: PhotosViewModelProtocol {
  
  // MARK: - Internal Properties
  var photosCount: Int { photos.count }
  var photos: [Photo] = []
  
  // MARK: - Private Properties
  private(set) var state: PassthroughSubject<StateController, Never>
  private let loadUseCase: any LoadPhotosUseCaseProtocol
  private let loadSearchPhotosUseCase: any LoadSearchPhotosUseCaseProtocol
  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadPhotosUseCaseProtocol,
    loadSearchPhotosUseCase: any LoadSearchPhotosUseCaseProtocol,
    lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
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
  
  func getPhotoListViewModelItem(
    at index: Int
  ) -> PhotosViewModelItem {
    checkAndLoadMorePhotos(at: index)
    return makePhotoListViewModelItem(at: index)
  }
  
  func checkAndLoadMorePhotos(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: viewDidLoad
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
  
  private func makePhotoListViewModelItem(at index: Int) -> PhotosViewModelItem {
    let photo = photos[index]
    return PhotosViewModelItem(photo: photo)
  }
}
