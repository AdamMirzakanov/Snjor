//
//  Pageable.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

protocol Pageable {
  var lastPage: Bool { get }
  mutating func updateLastPage(itemsCount: Int)
  func checkAndLoadMoreItems(
    item: Int,
    actualItems: Int,
    action: () -> Void
  )
}
