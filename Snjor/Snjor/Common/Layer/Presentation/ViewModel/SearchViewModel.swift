//
//  SearchViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

// MARK: - Protocol
protocol SearchViewModelProtocol <Item> : ItemsViewModelProtocol {
  func search(with searchTerm: String)
  func searchUseCase(with searchTerm: String) async
  func checkAndLoadMoreSearchItems(at index: Int, with searchTerm: String)
  func getSearchItemsViewModelItem(
    at index: Int,
    with searchTerm: String
  ) -> ViewModelItem<Item>
}

// MARK: - Class
class SearchViewModel <Element: HasRegularURL & Downloadable> : ItemsViewModel<Element>, SearchViewModelProtocol {
  
  func search(with searchTerm: String) {
    state.send(.loading)
    Task {
      await searchUseCase(with: searchTerm)
    }
  }
  
  func searchUseCase(with searchTerm: String) async {
    fatalError("This method must be overridden in a subclass")
  }
  
  func checkAndLoadMoreSearchItems(at index: Int, with searchTerm: String) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: items.count,
      action: { self.search(with: searchTerm) }
    )
  }
  
  func getSearchItemsViewModelItem(
    at index: Int,
    with searchTerm: String
  ) -> ViewModelItem <Element> {
    checkAndLoadMoreSearchItems(at: index, with: searchTerm)
    return makeViewModelItem(at: index)
  }
}
