//
//  SearchResultPhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

protocol SearchResultPhotosViewModelProtocol: BaseViewModelProtocol {
  var photos: [Photo] { get set }
  func getPhoto(at index: Int) -> Photo
  func checkAndLoadMorePhotos(at index: Int, with searchTerm: String)
  func loadSearchPhotos(with searchTerm: String)
  func getPhotoListViewModelItem(
    at index: Int,
    with searchTerm: String
  ) -> SearchResultPhotosViewModelItem
}
