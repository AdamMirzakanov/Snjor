//
//  SearchScreenViewModelFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

protocol SearchScreenViewModelFactoryProtocol {
  func createPhotosViewModel() -> PhotosViewModel
  func createAlbumsViewModel() -> AlbumsViewModel
  func createTopicsViewModel() -> TopicsViewModel
}
