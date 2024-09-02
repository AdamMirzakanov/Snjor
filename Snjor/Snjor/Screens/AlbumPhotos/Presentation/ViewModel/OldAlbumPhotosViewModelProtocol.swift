//
//  OldAlbumPhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

protocol OldAlbumPhotosViewModelProtocol: BaseViewModelProtocol {
  var photos: [Photo] { get }
  func getAlbumPhotosViewModelItem(at index: Int) -> OldPhotosViewModelItem
  func getPhoto(at index: Int) -> Photo
  func checkAndLoadMorePhotos(at index: Int)
}
