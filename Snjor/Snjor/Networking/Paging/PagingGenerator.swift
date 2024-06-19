//
//  PagingGenerator.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

struct PagingGenerator: Pageable {
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
    item: Int,
    actualItems: Int,
    action: () -> Void
  ) {
    guard !lastPage else { return }
    let limit = actualItems - threshold
    if limit == item {
      action()
    }
  }
}
