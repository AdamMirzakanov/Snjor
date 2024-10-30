//
//  SearchViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

/// Протокол `SearchViewModelProtocol` описывает интерфейс
/// для `ViewModel`, управляющего поиском элементов.
///
/// Он наследует от `ContentManagingProtocol` и добавляет методы
/// для выполнения поиска и управления состоянием элементов поиска.
protocol SearchViewModelProtocol<Item>: ContentManagingProtocol {
  
  /// Выполняет поиск по указанному тексту в поисковой строке.
  ///
  /// - Parameter searchTerm: Строка, по которой будет выполнен поиск.
  func executeSearch(with searchTerm: String)
  
  /// Асинхронный метод для выполнения поиска по указанному тексту.
  ///
  /// - Parameter searchTerm: Строка, по которой будет выполнен поиск.
  func searchUseCase(with searchTerm: String) async
  
  /// Проверяет необходимость загрузки дополнительных
  /// элементов поиска на основе индекса и текста поиска.
  ///
  /// - Parameters:
  ///   - index: Индекс элемента в массиве.
  ///   - searchTerm: Строка, по которой будет выполнен поиск.
  func checkAndLoadMoreSearchItems(at index: Int, with searchTerm: String)
  
  /// Возвращает объект `BaseViewModelItem` для элемента
  /// поиска по указанному индексу и строке поиска.
  ///
  /// - Parameters:
  ///   - index: Индекс элемента в массиве.
  ///   - searchTerm: Строка, по которой будет выполнен поиск.
  /// - Returns: Объект `BaseViewModelItem` для элемента поиска.
  func getSearchItemsViewModelItem(
    at index: Int,
    with searchTerm: String
  ) -> BaseViewModelItem<Item>
}
