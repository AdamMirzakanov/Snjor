//
//  LastPageValidationUseCase.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

struct LastPageValidationUseCase: Pageable {
  // MARK: - Private Properties
  private var threshold = 10
  private(set) var lastPage = false

  // MARK: - Public Methods
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
