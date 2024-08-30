//
//  PhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

protocol PhotosViewModelProtocol: BaseViewModelProtocol {
  var photos: [Photo] { get }
  func getPhoto(at index: Int) -> Photo
  func getPhotosViewModelItem(at index: Int) -> PhotosViewModelItem
  func checkAndLoadMorePhotos(at index: Int)
  
  func checkAndLoadMoreSearchPhotos(at index: Int, with searchTerm: String)
  func loadSearchPhotos(with searchTerm: String)
  func getSearchPhotosViewModelItem(
    at index: Int,
    with searchTerm: String
  ) -> PhotosViewModelItem
}
