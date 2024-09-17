//
//  UserPhotosViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import Combine

final class UserPhotosViewModel: BaseViewModel<Photo> {
  // MARK: Private Properties
  private let loadUseCase: any LoadUserPhotosUseCaseProtocol
  
  // MARK: Initializers
  init(
    loadUseCase: any LoadUserPhotosUseCaseProtocol,
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
