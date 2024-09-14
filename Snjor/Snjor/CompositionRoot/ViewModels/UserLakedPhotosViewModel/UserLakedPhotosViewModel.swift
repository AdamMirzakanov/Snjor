//
//  UserLakedPhotosViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.09.2024.
//

import Combine

final class UserLakedPhotosViewModel: BaseViewModel<Photo> {
  // MARK: Private Properties
  private let loadUseCase: any LoadUserLikedPhotosUseCaseProtocol
  
  // MARK: Initializers
  init(
    loadUseCase: any LoadUserLikedPhotosUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.loadUseCase = loadUseCase
    super.init(
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  // MARK: Override Methods
  override func loadItemsUseCase() async {
    let result = await loadUseCase.execute()
    updateStateUI(with: result)
  }
}
