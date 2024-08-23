//
//  PhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

protocol PhotosViewModelProtocol: BaseViewModelProtocol {
  var photosCount: Int { get }
  var photos: [Photo] { get }
  func getPhoto(at index: Int) -> Photo
  func getPhotoListViewModelItem(at index: Int) -> PhotosViewModelItem
  func checkAndLoadMorePhotos(at index: Int)
}
