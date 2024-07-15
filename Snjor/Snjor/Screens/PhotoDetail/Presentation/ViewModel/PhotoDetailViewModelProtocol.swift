//
//  PhotoDetailViewModelProtocol.swift
//  Snjor
//
//  Created by Адам on 15.07.2024.
//

protocol PhotoDetailViewModelProtocol: BaseViewModelProtocol {
  var photo: Photo? { get set }
  var width: Int { get }
  var height: Int { get }
  var displayName: String { get }
  var likes: String { get }
  var downloads: String { get }
  var createdAt: String { get }
  var cameraModel: String { get }
  var iso: String { get }
  var focalLength: String { get }
  var aperture: String { get }
  var exposureTime: String { get }
  var pixels: String { get }
  var resolution: String { get }
}
