//
//  PhotoDetailViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 31.07.2024.
//

struct PhotoDetailViewModelItem {
  var photo: Photo
  
  var displayName: String {
    photo.user.displayName
  }
  
  var likes: String {
    String(photo.likes ?? .zero)
  }
  
  var downloads: String {
    String(photo.downloads ?? .zero)
  }
  
  var createdAt: String {
    photo.createdAt
  }
  
  var cameraModel: String {
    photo.exif?.model?.uppercased() ?? .defaultCamera
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
    return photo.exif?.iso.map { String($0) } ?? .dash
  }

  var focalLength: String {
    let focalLength = photo.exif?.focalLength ?? .dash
    return focalLength == .dash ? focalLength : focalLength + .mm
  }
  
  var aperture: String {
    let aperture = photo.exif?.aperture ?? .dash
    return aperture == .dash ? aperture : .𝑓 + aperture
  }

  var exposureTime: String {
    let time = photo.exif?.exposureTime ?? .dash
    return time == .dash ? time : time + .second
  }
  
  var location: String {
    let syty = photo.location?.city
    return syty ?? .empty
  }
  
  var tags: [Tag]? {
    let tags = photo.tags
    return tags
  }
  
  // MARK: Private Methods
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
