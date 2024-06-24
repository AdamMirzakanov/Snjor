//
//  PhotoDetailViewModel.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation
import Combine

protocol PhotoDetailViewModelProtocol: BaseViewModelProtocol {
  var name: String { get }
  var location: String { get }
  var model: String { get }
  var width: Int { get }
  var height: Int { get }
  var iso: Int { get }
  var aperture: String { get }
  var focalLength: String { get }
  var exposureTime: String { get }
  var likes: Int { get }
}

final class PhotoDetailViewModel: PhotoDetailViewModelProtocol {
  // MARK: - Public Properties
  var state: PassthroughSubject<StateController, Never>
  var name: String { "\(photo?.user.firstName ?? "-") \(photo?.user.lastName ?? "-")" }
  var location: String { photo?.user.location ?? "-" }
  var model: String { photo?.exif?.model ?? "-" }
  var width: Int { photo?.width ?? 0 }
  var height: Int { photo?.height ?? 0 }
  var iso: Int { photo?.exif?.iso ?? 0 }
  var aperture: String { photo?.exif?.aperture ?? "-" }
  var focalLength: String { photo?.exif?.focalLength ?? "-" }
  var exposureTime: String { photo?.exif?.exposureTime ?? "-" }
  var likes: Int { photo?.user.totalLikes ?? 0 }

  // MARK: - Private Properties
  let loadPhotoDetailUseCase: any LoadPhotoDetailUseCaseProtocol
  var photo: Photo?

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
    guard let photo = photo else { return }
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
