//
//  ContentManagingProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

/// Протокол `ContentManagingProtocol` предоставляет общие
/// свойства и методы для управления контентом элементов.
///
/// Этот протокол наследуется от `BaseViewModelProtocol` и обеспечивает
/// доступ к элементам, их количеству и методам для работы с ними.
///
/// - Parameters:
///   - Item: Тип элемента, который должен соответствовать
///   протоколам `ViewModelItemRepresentable` и `Downloadable`.
protocol ContentManagingProtocol<Item>: BaseViewModelProtocol {
  
  /// Тип элемента, которым управляет `ContentManagingProtocol`.
  associatedtype Item: ViewModelItemRepresentable & Downloadable
  
  // MARK: - Internal Properties
  /// Количество элементов.
  var itemsCount: Int { get }
  
  /// Массив элементов.
  var items: [Item] { get }
  
  // MARK: - Internal Methods
  /// Возвращает элемент по указанному индексу.
  ///
  /// - Parameter index: Индекс элемента в массиве.
  /// - Returns: Элемент типа `Item`.
  func getItem(at index: Int) -> Item
  
  /// Возвращает объект `BaseViewModelItem` по указанному индексу.
  ///
  /// - Parameter index: Индекс элемента в массиве.
  /// - Returns: Объект `BaseViewModelItem`.
  func getViewModelItem(at index: Int) -> BaseViewModelItem<Item>
  
  /// Метод для асинхронной загрузки элементов
  /// - Note: должен быть переопределен и реализован в конкретной реализации протокола
  func loadItemsUseCase() async
  
  /// Проверяет необходимость загрузки дополнительных элементов на
  /// основе индекса и текущего количества элементов.
  ///
  /// - Parameter index: Индекс элемента в массиве.
  func checkAndLoadMoreItems(at index: Int)
}

