//
//  LastPageValidationUseCaseProtocol.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

/// Протокол для проверки состояния последней страницы и
/// загрузки дополнительных данных при необходимости.
protocol LastPageValidationUseCaseProtocol {
  
  /// Свойство, показывающее, является ли текущая страница последней.
  var lastPage: Bool { get }
  
  /// Обновляет информацию о том, является ли текущая страница последней.
  /// - Parameter itemsCount: Количество элементов, полученных на текущей странице.
  mutating func updateLastPage(itemsCount: Int)
  
  /// Проверяет индекс текущего элемента и запускает действие по
  /// загрузке дополнительных элементов, если необходимо.
  ///
  /// - Parameters:
  ///   - itemIndex: Индекс текущего элемента для проверки.
  ///   - actualItems: Фактическое количество элементов, отображаемых в списке.
  ///   - action: Замыкание, которое выполняется, если требуется загрузка дополнительных данных.
  func checkAndLoadMoreItems(
    at itemIndex: Int,
    actualItems: Int,
    action: @escaping () -> Void
  )
}
