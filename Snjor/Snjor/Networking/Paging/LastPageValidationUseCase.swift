//
//  LastPageValidationUseCase.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

fileprivate typealias Const = LastPageValidationUseCaseConst

/// Реализация `LastPageValidationUseCaseProtocol`
/// для проверки и обновления состояния последней страницы.
struct LastPageValidationUseCase: LastPageValidationUseCaseProtocol {
  
  // MARK: Private Properties
  /// Пороговое значение, определяющее, когда необходимо загружать дополнительные данные.
  private var threshold: Int = Const.thresholdValue
  private(set) var lastPage = false

  // MARK: Internal Methods
  mutating func updateLastPage(itemsCount: Int) {
    if itemsCount == Int.zero {
      lastPage = false
    }
  }

  func checkAndLoadMoreItems(
    at itemIndex: Int,
    actualItems: Int,
    action: () -> Void
  ) {
    guard !lastPage else { return }
    let limit = actualItems - threshold
    if limit == itemIndex {
      action()
    }
  }
}
