//
//  PhotoDetailViewModel.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Combine
import Photos

final class PhotoDetailViewModel: PhotoDetailViewModelProtocol {
  // MARK: - Computed Properties
  var displayName: String {
    photo?.user.displayName ?? .defaultUserName
  }
  
  var likes: String {
    String(photo?.likes ?? .zero)
  }
  
  var downloads: String {
    String(photo?.downloads ?? .zero)
  }
  
  var createdAt: String {
    photo?.createdAt ?? .defaultDate
  }
  
  var cameraModel: String {
    photo?.exif?.model?.uppercased() ?? .defaultCamera
  }
  
  var width: Int {
    photo?.width ?? .zero
  }
  
  var height: Int {
    photo?.height ?? .zero
  }
  
  var resolution: String {
    determineResolutionCategory(width: width, height: height)
  }
  
  var pixels: String {
    "\(width) × \(height)"
  }

  var iso: String {
    return photo?.exif?.iso.map { String($0) } ?? .dash
  }

  var focalLength: String {
    let focalLength = photo?.exif?.focalLength ?? .dash
    return focalLength == .dash ? focalLength : focalLength + .mm
  }
  
  var aperture: String {
    let aperture = photo?.exif?.aperture ?? .dash
    return aperture == .dash ? aperture : .𝑓 + aperture
  }

  var exposureTime: String {
    let time = photo?.exif?.exposureTime ?? .dash
    return time == .dash ? time : time + .second
  }

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
      do {
        let photo = try await loadUseCase.execute()
        self.photo = photo
        state.send(.success)
      } catch {
        state.send(.fail(error: error.localizedDescription))
      }
    }
  }
  
  // MARK: - Private Methods
  private func determineResolutionCategory(width: Int, height: Int) -> String {
    let maxDimension = max(width, height)
    switch maxDimension {
    case 7680...:
      return .uhd8K
    case 3840..<7680:
      return .uhd4K
    case 2560..<3840:
      return .qhd2K
    case 1920..<2560:
      return .fullHD
    case 1280..<1920:
      return .hd
    default:
      return .dash
    }
  }
}
