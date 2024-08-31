//
//  AlbumPhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

protocol AlbumPhotosViewModelProtocol: BaseViewModelProtocol {
  var photos: [Photo] { get }
  func getAlbumPhotosViewModelItem(at index: Int) -> PhotosViewModelItem
  func getPhoto(at index: Int) -> Photo
  func checkAndLoadMorePhotos(at index: Int)
}
