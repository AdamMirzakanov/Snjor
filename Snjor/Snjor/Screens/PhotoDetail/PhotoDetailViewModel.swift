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
  private let dataImageUseCase: any ImageDataUseCaseProtocol

  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadPhotoDetailUseCase: any LoadPhotoDetailUseCaseProtocol,
    dataImageUseCase: any ImageDataUseCaseProtocol
  ) {
    self.state = state
    self.loadPhotoDetailUseCase = loadPhotoDetailUseCase
    self.dataImageUseCase = dataImageUseCase
  }

  // MARK: - Public Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      do {
        let photo = try await loadPhotoDetailUseCase.execute()
        self.photo = photo
        state.send(.success)
      } catch {
        state.send(.fail(error: error.localizedDescription))
      }
    }
  }
}
