//
//  SearchScreenViewModelProviderProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

protocol SearchScreenViewModelProviderProtocol {
  func createPhotosViewModel() -> DiscoverViewModel
  func createTopicsViewModel() -> TopicsViewModel
  func createAlbumsViewModel() -> AlbumsViewModel
  func createUsersViewModel() -> UsersViewModel
}
