//
//  LastPageValidationUseCase.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

final class LastPageValidationUseCase: LastPageValidationUseCaseProtocol {
  // MARK: Private Properties
  private let loadQueue = DispatchQueue(label: .loadQueue, qos: .userInitiated)
  private let threshold = LastPageValidationUseCaseConst.thresholdValue
  private(set) var lastPage = false
  private var isLoading = false
  private var loadWorkItem: DispatchWorkItem?
  
  // MARK: Internal Methods
  func updateLastPage(itemsCount: Int) {
    if itemsCount < threshold {
      lastPage = true
    }
  }
  
  func checkAndLoadMoreItems(
    at itemIndex: Int,
    actualItems: Int,
    action: @escaping () -> Void
  ) {
    guard
      !lastPage,
      !isLoading,
      itemIndex >= actualItems - threshold
    else {
      return
    }
    loadWorkItem?.cancel()
    isLoading = true
    loadWorkItem = DispatchWorkItem { [weak self] in
      guard let self = self else { return }
      self.startLoading(action: action)
    }
    if let loadWorkItem = loadWorkItem {
      loadQueue.asyncAfter(
        deadline: .now() + .loadDelay,
        execute: loadWorkItem
      )
    }
  }

  // MARK: Private Methods
  private func startLoading(action: @escaping () -> Void) {
    action()
    self.isLoading = false
  }
}

// MARK: - Double
private extension Double {
  static let loadDelay = 0.3
}

// MARK: - String
private extension String {
  static let loadQueue = "loadQueue"
}
