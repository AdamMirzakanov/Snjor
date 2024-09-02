//
//  OldTopicPhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

protocol OldTopicPhotosViewModelProtocol: BaseViewModelProtocol {
  var photos: [Photo] { get }
  func getTopicPhotoListViewModelItem(
    at index: Int
  ) -> OldPhotosViewModelItem
  func getPhoto(at index: Int) -> Photo
  func checkAndLoadMorePhotos(at index: Int)
}
