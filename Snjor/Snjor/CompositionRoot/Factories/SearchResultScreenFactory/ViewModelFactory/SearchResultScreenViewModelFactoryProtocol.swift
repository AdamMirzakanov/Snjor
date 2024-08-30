//
//  SearchResultScreenViewModelFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

protocol SearchResultScreenViewModelFactoryProtocol {
  func createSearchPhotosViewModel() -> PhotosViewModel
  func createSearchAlbumsViewModel() -> AlbumsViewModel
}
 
