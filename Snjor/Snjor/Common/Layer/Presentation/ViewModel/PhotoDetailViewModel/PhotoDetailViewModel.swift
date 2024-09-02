//
//  PhotoDetailViewModel.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Combine

final class PhotoDetailViewModel: PhotoDetailViewModelProtocol {
  
  // MARK: - Internal Properties
  var state: PassthroughSubject<StateController, Never>
  var photo: Photo?
  
  // MARK: - Private Properties
  private let loadUseCase: any LoadPhotoDetailUseCaseProtocol
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadPhotoDetailUseCaseProtocol
  ) {
    self.state = state
    self.loadUseCase = loadUseCase
  }
  
  // MARK: - Internal Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadPhotoDetailUseCase()
    }
  }
  
  func getPhotoDetailViewModelItem() -> PhotoDetailViewModelItem? {
    guard let photo = photo else { return nil }
    return PhotoDetailViewModelItem(photo: photo)
  }
  
  // MARK: - Private Methods
  private func loadPhotoDetailUseCase() async {
    do {
      let photo = try await loadUseCase.execute()
      self.photo = photo
      state.send(.success)
    } catch {
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
