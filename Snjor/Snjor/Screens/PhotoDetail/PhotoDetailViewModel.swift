//
//  PhotoDetailViewModel.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation
import Combine

protocol PhotoDetailViewModelProtocol: BaseViewModelProtocol {
  var photo: Photo? { get }
}

final class PhotoDetailViewModel: PhotoDetailViewModelProtocol {
  // MARK: - Public Properties
  var state: PassthroughSubject<StateController, Never>
  var photo: Photo?

  // MARK: - Private Properties
  private let loadPhotoDetailUseCase: any LoadPhotoDetailUseCaseProtocol

  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadPhotoDetailUseCase: any LoadPhotoDetailUseCaseProtocol
  ) {
    self.state = state
    self.loadPhotoDetailUseCase = loadPhotoDetailUseCase
  }

  // MARK: - Public Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadPhotoDetailUseCase()
    }
  }

  // MARK: - Private Methods
  private func loadPhotoDetailUseCase() async {
    guard photo != nil else { return }
    let result = await loadPhotoDetailUseCase.execute()
    updateState(with: result)
  }

  private func updateState(with result: Result<Photo, Error>) {
    switch result {
    case .success(let photo):
      self.photo = photo
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
