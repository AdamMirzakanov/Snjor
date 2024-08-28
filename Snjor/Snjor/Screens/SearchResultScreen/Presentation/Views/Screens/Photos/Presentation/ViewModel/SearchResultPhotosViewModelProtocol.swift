//
//  SearchResultPhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

protocol SearchResultPhotosViewModelProtocol: BaseViewModelProtocol {
  var photos: [Photo] { get set }
  func getPhoto(at index: Int) -> Photo
  func getPhotoListViewModelItem(at index: Int) -> SearchResultPhotosViewModelItem
  func checkAndLoadMorePhotos(at index: Int)
  func loadSearchPhotos(with searchTerm: String)
}
