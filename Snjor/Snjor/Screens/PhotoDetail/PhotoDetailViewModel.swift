//
//  PhotoDetailViewModel.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation
import Combine
import Photos

protocol PhotoDetailViewModelProtocol: BaseViewModelProtocol {
  var displayName: String { get }
  var likes: String { get }
  var downloads: String { get }
  var views: String { get }
  var createdAt: String { get }
  var cameraModel: String { get }
  var width: Int { get }
  var height: Int { get }
  var iso: String { get }
  var focalLength: String { get }
  var aperture: String { get }
  var exposureTime: String { get }
  var instagramUsername: String { get }
  var twitterUsername: String { get }
  var pixels: String { get }
  var resolution: String { get }
  var backgroundImageData: Data? { get }
  var photo: Photo? { get set }
}

final class PhotoDetailViewModel: PhotoDetailViewModelProtocol {
  
  // MARK: - Public Properties
  var displayName: String {
    photo?.user.displayName ?? .empty
  }
  
  var likes: String {
    "\(photo?.likes ?? .zero)"
  }
  
  var downloads: String {
    "\(photo?.downloads ?? .zero)"
  }
  
  var views: String {
    "\(photo?.user.totalPhotos ?? .zero)"
  }
  
  var createdAt: String {
    photo?.createdAt ?? .empty
  }
  
  var cameraModel: String {
    photo?.exif?.model ?? .cameraDefault
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
    "\(photo?.exif?.iso ?? .zero)"
  }
  
  var focalLength: String {
    (photo?.exif?.focalLength ?? .focalLengtDefault) + .millimeter
  }
  
  var aperture: String {
    .𝑓 + .space + (photo?.exif?.aperture ?? .apertureDefault)
  }
  
  var exposureTime: String {
    (photo?.exif?.exposureTime ?? .exposureDefault) + .second
  }
  
  var instagramUsername: String {
    photo?.user.social?.instagramUsername ?? .instagramUsernameDefault
  }
  
  var twitterUsername: String {
    photo?.user.social?.twitterUsername ?? .twitterUsernameDefault
  }
  
  var backgroundImageData: Data? {
    let url = photo!.urls[.regular]
    return imageDataUseCase.getDataFromCache(url: url)
  }
  
  var state: PassthroughSubject<StateController, Never>
  
  // MARK: - Private Properties
  private let loadPhotoDetailUseCase: any LoadPhotoDetailUseCaseProtocol
  private let imageDataUseCase: any ImageDataUseCaseProtocol
  var photo: Photo?
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadPhotoDetailUseCase: any LoadPhotoDetailUseCaseProtocol,
    imageDataUseCase: any ImageDataUseCaseProtocol
  ) {
    self.state = state
    self.loadPhotoDetailUseCase = loadPhotoDetailUseCase
    self.imageDataUseCase = imageDataUseCase
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
      return .standard
    }
  }
}
