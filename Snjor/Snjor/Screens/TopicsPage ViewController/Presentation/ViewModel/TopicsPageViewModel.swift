//
//  TopicsPageViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import Foundation
import Combine

final class TopicsPageViewModel: TopicsPageViewModelProtocol {

  // MARK: - Internal Properties
  var topicsCount: Int { topics.count }

  // MARK: - Private Properties
  private(set) var state: PassthroughSubject<StateController, Never>
  private let loadTopicsPageUseCase: any LoadTopicsPageUseCaseProtocol
  var topics: [Topic] = []

  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadTopicsPageUseCase: any LoadTopicsPageUseCaseProtocol
  ) {
    self.state = state
    self.loadTopicsPageUseCase = loadTopicsPageUseCase
  }

  // MARK: - Internal Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadTopicsPageUseCase()
    }
  }

  // MARK: - Private Methods
  private func loadTopicsPageUseCase() async {
    let result = await loadTopicsPageUseCase.execute()
    updateStateUI(with: result)
  }

  private func updateStateUI(with result: Result<[Topic], Error>) {
    switch result {
    case .success(let topics):
      self.topics.append(contentsOf: topics)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
