//
//  BaseViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine
import Foundation

/// `ElementProtocol` объединяет функционал
/// протоколов `ViewModelItemRepresentable` и `Downloadable`.
typealias ElementProtocol = ViewModelItemRepresentable & Downloadable

/// Класс `BaseViewModel` является базовой реализацией для
/// управления контентом и обработкой состояний для элементов,
/// которые соответствуют протоколу `ElementProtocol`.
///
/// - Parameters:
///   - Element: Тип элемента, соответствующий `ElementProtocol`.
class BaseViewModel<Element: ElementProtocol>: ContentManagingProtocol {
  
  // MARK: ContentManagingProtocol Properties
  var items: [Element] = []
  var itemsCount: Int { return items.count }
  
  // MARK: BaseViewModelProtocol Properties
  var state: PassthroughSubject<StateController, Never>
  
  // MARK: Internal Properties
  /// Объект, отвечающий за проверку последней страницы.
  var lastPageValidationUseCase: (any LastPageValidationUseCaseProtocol)?
  
  // MARK: Initializers
  init(
    lastPageValidationUseCase: (any LastPageValidationUseCaseProtocol)? = nil,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.lastPageValidationUseCase = lastPageValidationUseCase
    self.state = state
  }
  
  // MARK: Internal Methods
  /// Обновляет состояние пользовательского интерфейса на основе результата.
  ///
  /// - Parameter result: Результат загрузки элементов.
  func updateStateUI(with result: Result<[Element], Error>) {
    switch result {
    case .success(let items):
      let existingItemIDs = self.items.map { $0.id }
      // фильтрация полученных элементов для предотвращения дублирования
      let newItems = items.filter { !existingItemIDs.contains($0.id) }
      lastPageValidationUseCase?.updateLastPage(itemsCount: newItems.count)
      self.items.append(contentsOf: newItems)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
  
  /// Создает и возвращает объект `BaseViewModelItem` для указанного индекса.
  ///
  /// - Parameter index: Индекс элемента в массиве.
  /// - Returns: Объект `BaseViewModelItem`.
  func makeViewModelItem(at index: Int) -> BaseViewModelItem<Element> {
    let item = items[index]
    return BaseViewModelItem(item: item)
  }
  
  // MARK: - BaseViewModelProtocol Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadItemsUseCase()
    }
  }
  
  // MARK: - ContentManagingProtocol Methods
  func getItem(at index: Int) -> Element {
    items[index]
  }
  
  func getViewModelItem(at index: Int) -> BaseViewModelItem<Element> {
    checkAndLoadMoreItems(at: index)
    return makeViewModelItem(at: index)
  }
  
  func loadItemsUseCase() async {
    // переопределяется в наследниках
  }
  
  func checkAndLoadMoreItems(at index: Int) {
    lastPageValidationUseCase?.checkAndLoadMoreItems(
      at: index,
      actualItems: itemsCount,
      action: viewDidLoad
    )
  }
}
