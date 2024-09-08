//
//  TopicsViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine

final class TopicsViewModel: BaseViewModel<Topic> {
  // MARK: Private Properties
  private let loadUseCase: any LoadTopicsUseCaseProtocol
  
  // MARK: Initializers
  init(
    loadUseCase: any LoadTopicsUseCaseProtocol,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.loadUseCase = loadUseCase
    super.init(state: state)
  }
  
  // MARK: Override Methods
  override func loadItemsUseCase() async {
    let result = await loadUseCase.execute()
    updateStateUI(with: result)
  }
  
  override func updateStateUI(with result: Result<[Topic], any Error>) {
    super.updateStateUI(with: result)
    TopicsAndAlbumsItem.topics = self.items.map { TopicsAndAlbumsItem.topic ($0) }
  }
}
