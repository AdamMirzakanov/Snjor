//
//  TopicsViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine

class TopicsViewModel: ItemsViewModel <Topic> {
  
  private let loadUseCase: any LoadTopicsUseCaseProtocol
  
  // MARK: Initializers
  init(
    loadUseCase: any LoadTopicsUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.loadUseCase = loadUseCase
    super.init(
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  // MARK: Private Methods
  override func loadItemsUseCase() async {
    let result = await loadUseCase.execute()
    updateStateUI(with: result)
  }
  
  override func updateStateUI(with result: Result<[Topic], any Error>) {
    super.updateStateUI(with: result)
    CollectionsItem.topics = self.items.map { CollectionsItem.topic ($0) }
  }
}
