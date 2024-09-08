//
//  UsersViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

import Combine

final class UsersViewModel: SearchViewModel<User> {
  // MARK: Private Properties
  private let loadSearchUsersUseCase: any LoadSearchUsersUseCaseProtocol
  
  // MARK: Initializers
  init(
    loadSearchUsersUseCase: any LoadSearchUsersUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.loadSearchUsersUseCase = loadSearchUsersUseCase
    super.init(
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  // MARK: Override Methods
  override func searchUseCase(with searchTerm: String) async {
    let result = await loadSearchUsersUseCase.execute(with: searchTerm)
    updateStateUI(with: result)
  }
}
