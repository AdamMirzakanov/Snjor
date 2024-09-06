//
//  LastPageValidationUseCase.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

struct LastPageValidationUseCase: LastPageValidationUseCaseProtocol {
  
  // MARK: Private Properties
  private var threshold: Int = LastPageValidationUseCaseConst.thresholdValue
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
