//
//  PhotoDetailViewModelItem.swift
//  Snjor
//
//  Created by Адам on 30.06.2024.
//

import Foundation

struct PhotoDetailViewModelItem {

  private(set) var photo: Photo
  private(set) var dataImageUseCase: any ImageDataUseCaseProtocol

  // MARK: - Public Properties
  var displayName: String {
    photo.user.displayName
  }

  var likes: String {
    "\(photo.likes ?? .zero)"
  }

  var downloads: String {
    "\(photo.downloads ?? .zero)"
  }

  var views: String {
    "\(photo.user.totalPhotos)"
  }

  var createdAt: String {
    photo.createdAt
  }

  var cameraModel: String {
    photo.exif?.model ?? .cameraDefault
  }

  var width: Int {
    photo.width
  }

  var height: Int {
    photo.height
  }

  var resolution: String {
    determineResolutionCategory(width: width, height: height)
  }

  var pixels: String {
    "\(width) × \(height)"
  }

  var iso: String {
    .iso + "\(photo.exif?.iso ?? .zero)"
  }

  var focalLength: String {
    (photo.exif?.focalLength ?? .focalLengtDefault) + .millimeter
  }

  var aperture: String {
    .aperture + (photo.exif?.aperture ?? .apertureDefault)
  }

  var exposureTime: String {
    (photo.exif?.exposureTime ?? .exposureDefault) + .second
  }

  var profileImageData: Data? {
    dataImageUseCase.getDataFromCache(url: photo.urls[.regular])
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
