//
//  UserProfileViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

import Combine

final class UserProfileViewModel: BaseViewModel<User>, UserProfileViewModelProtocol {
  // MARK: Internal Properties
  var user: User?
  
  // MARK: Private Properties
  private let loadUseCase: any LoadUserProfileUseCaseProtocol
  
  // MARK: Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadUserProfileUseCaseProtocol
  ) {
    self.loadUseCase = loadUseCase
    super.init(state: state)
  }
  
  // MARK: Internal Methods
  override func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadUserProfileUseCase()
    }
  }
  
  func getUserProfileViewModelItem() -> UserProfileViewModelItem? {
    guard let user = user else { return nil }
    return UserProfileViewModelItem(user: user)
  }
  
  // MARK: Private Methods
  private func loadUserProfileUseCase() async {
    do {
      let user = try await loadUseCase.execute()
      self.user = user
      state.send(.success)
    } catch {
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
