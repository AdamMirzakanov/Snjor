//
//  UserProfileViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

import Combine

final class UserProfileViewModel: BaseViewModel<User>, UserProfileViewModelProtocol {
  // MARK: Internal Properties
  private var user: User?
  private var photo: Photo?
  
  // MARK: Private Properties
  private let loadUseCase: any LoadUserProfileUseCaseProtocol
  private let loadRandomPhotoUseCase: any LoadRandomUserPhotoUseCaseProtocol
  
  // MARK: Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadUserProfileUseCaseProtocol,
    loadRandomPhotoUseCase: any LoadRandomUserPhotoUseCaseProtocol
  ) {
    self.loadUseCase = loadUseCase
    self.loadRandomPhotoUseCase = loadRandomPhotoUseCase
    super.init(state: state)
  }
  
  // MARK: Internal Methods
  override func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadUserProfileUseCase()
      await loadRandomPhotoUseCase()
    }
  }
  
  func getUserProfileViewModelItem() -> UserProfileViewModelItem? {
    guard
      let user = user,
      let photo = photo else {
      return nil
    }
    return UserProfileViewModelItem(user: user, photo: photo)
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
  
  private func loadRandomPhotoUseCase() async {
    do {
      let photo = try await loadRandomPhotoUseCase.execute()
      self.photo = photo
      state.send(.success)
    } catch {
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
