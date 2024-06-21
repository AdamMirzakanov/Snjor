//
//  PhotoDetailViewModel.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation
import Combine

protocol PhotoDetailViewModelProtocol: BaseViewModelProtocol {
  //  var name: String { get set }
  //  var location: String { get set }
  //  var created: String { get set }
  //  var model: String { get set }
  //  var width: Int { get set }
  //  var height: Int { get set }
  //  var iso: String { get set }
  //  var aperture: String { get set }
  //  var focalLength: String { get set }
  //  var exposureTime: String { get set }
  //  var likes: Int { get set }

  var name: String { get }
  var location: String { get }
  var model: String { get }
  var width: Int { get }
  var height: Int { get }
  var iso: String { get }
  var aperture: String { get }
  var focalLength: String { get }
  var exposureTime: String { get }
  var likes: Int { get }
}

final class PhotoDetailViewModel: PhotoDetailViewModelProtocol {

  var name: String {
    "\(photo?.user.firstName ?? "-") \(photo?.user.lastName ?? "-")"
  }

  var location: String {
    "-"
  }

  var model: String {
    "-"
  }

  var width: Int {
    photo?.width ?? 0
  }

  var height: Int {
    photo?.height ?? 0
  }

  var iso: String {
    "-"
  }

  var aperture: String {
    "-"
  }

  var focalLength: String {
    "-"
  }

  var exposureTime: String {
    "-"
  }

  var likes: Int {
    0
  }

  var state: PassthroughSubject<StateController, Never>
  let loadPhotoDetailUseCase: any LoadPhotoDetailUseCaseProtocol
  private var photo: Photo?

  init(
    state: PassthroughSubject<StateController, Never>,
    loadPhotoDetailUseCase: any LoadPhotoDetailUseCaseProtocol
  ) {
    self.state = state
    self.loadPhotoDetailUseCase = loadPhotoDetailUseCase
  }

  func viewDidLoad() {
    state.send(.loading)
    Task {
      do {
        let photoResult = try await loadPhotoDetailUseCase.execute()
        photo = photoResult
        state.send(.success)
      } catch {
        state.send(.fail(error: error.localizedDescription))
      }
    }
  }
}
