//
//  SearchViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

protocol SearchViewModelProtocol<Item>: ContentManagingProtocol {
  func executeSearch(with searchTerm: String)
  func searchUseCase(with searchTerm: String) async
  func checkAndLoadMoreSearchItems(at index: Int, with searchTerm: String)
  func getSearchItemsViewModelItem(
    at index: Int,
    with searchTerm: String
  ) -> BaseViewModelItem<Item>
}
