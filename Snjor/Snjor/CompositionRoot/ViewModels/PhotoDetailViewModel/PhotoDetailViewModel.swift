//
//  PhotoDetailViewModel.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Combine

final class PhotoDetailViewModel: BaseViewModel<Photo>, PhotoDetailViewModelProtocol {
  // MARK: Internal Properties
  var photo: Photo?
  
  // MARK: Private Properties
  private let loadUseCase: any LoadPhotoDetailUseCaseProtocol
  
  // MARK: Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadPhotoDetailUseCaseProtocol
  ) {
    self.loadUseCase = loadUseCase
    super.init(state: state)
  }
  
  // MARK: Internal Methods
  override func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadPhotoDetailUseCase()
    }
  }
  
  func getPhotoDetailViewModelItem() -> PhotoDetailViewModelItem? {
    guard let photo = photo else { return nil }
    return PhotoDetailViewModelItem(photo: photo)
  }
  
  // MARK: Private Methods
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
