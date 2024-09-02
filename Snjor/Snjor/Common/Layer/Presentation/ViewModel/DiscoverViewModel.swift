//
//  DiscoverViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine

class DiscoverViewModel: SearchViewModel <Photo> {
  
  private let loadUseCase: any LoadPhotosUseCaseProtocol
  private let loadSearchPhotosUseCase: any LoadSearchPhotosUseCaseProtocol
   
  // MARK: Initializers
  init(
    loadUseCase: any LoadPhotosUseCaseProtocol,
    loadSearchPhotosUseCase: any LoadSearchPhotosUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.loadUseCase = loadUseCase
    self.loadSearchPhotosUseCase = loadSearchPhotosUseCase
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
  
  override func searchUseCase(with searchTerm: String) async {
    let result = await loadSearchPhotosUseCase.execute(with: searchTerm)
    updateStateUI(with: result)
  }
}
