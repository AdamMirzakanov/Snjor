//
//  SearchViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

/// `SearchViewModel` является классом, который управляет
/// логикой поиска элементов и наследуется от `BaseViewModel`.
///
/// - Параметр `Element` должен соответствовать протоколу `ElementProtocol`,
/// который описывает свойства элементов для отображения в результате поиска.
class SearchViewModel<Element: ElementProtocol>: BaseViewModel<Element>, SearchViewModelProtocol {
  
  func executeSearch(with searchTerm: String) {
    state.send(.loading)
    Task {
      await searchUseCase(with: searchTerm)
    }
  }
  
  func searchUseCase(with searchTerm: String) async { }
  
  func checkAndLoadMoreSearchItems(at index: Int, with searchTerm: String) {
    lastPageValidationUseCase?.checkAndLoadMoreItems(
      at: index,
      actualItems: items.count,
      action: { self.executeSearch(with: searchTerm) }
    )
  }
  
  func getSearchItemsViewModelItem(
    at index: Int,
    with searchTerm: String
  ) -> BaseViewModelItem<Element> {
    checkAndLoadMoreSearchItems(at: index, with: searchTerm)
    return makeViewModelItem(at: index)
  }
}
