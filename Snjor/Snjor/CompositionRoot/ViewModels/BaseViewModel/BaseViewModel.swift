//
//  BaseViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine
import Foundation

typealias ElementProtocol = ViewModelItemRepresentable & Downloadable

class BaseViewModel<Element: ElementProtocol>: ContentManagingProtocol {
  typealias Item = Element
  
  // MARK: Internal Properties
  var items: [Element] = []
  var lastPageValidationUseCase: (any LastPageValidationUseCaseProtocol)?
  var state: PassthroughSubject<StateController, Never>
  var itemsCount: Int { return items.count }
  
  // MARK: Initializers
  init(
    lastPageValidationUseCase: (any LastPageValidationUseCaseProtocol)? = nil,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.lastPageValidationUseCase = lastPageValidationUseCase
    self.state = state
  }
  
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadItemsUseCase()
    }
  }
  
  // MARK: Internal Methods
  func getItem(at index: Int) -> Element {
    items[index]
  }
  
  func getViewModelItem(at index: Int) -> BaseViewModelItem<Element> {
    checkAndLoadMoreItems(at: index)
    return makeViewModelItem(at: index)
  }
  
  func loadItemsUseCase() async {
    
  }
  
  func updateStateUI(with result: Result<[Element], Error>) {
    switch result {
    case .success(let items):
      let existingItemIDs = self.items.map { $0.id }
      let newItems = items.filter { !existingItemIDs.contains($0.id) }
      lastPageValidationUseCase?.updateLastPage(itemsCount: newItems.count)
      self.items.append(contentsOf: newItems)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
  
  // MARK: Private Methods
  func makeViewModelItem(at index: Int) -> BaseViewModelItem<Element> {
    let item = items[index]
    return BaseViewModelItem(item: item)
  }
  
  func checkAndLoadMoreItems(at index: Int) {
    lastPageValidationUseCase?.checkAndLoadMoreItems(
      at: index,
      actualItems: itemsCount,
      action: viewDidLoad
    )
  }
}
