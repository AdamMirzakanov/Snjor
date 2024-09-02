//
//  AlbumsViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine

class AlbumsViewModel: SearchViewModel <Album> {
  
  private let loadUseCase: any LoadAlbumsUseCaseProtocol
  private let loadSearchAlbumsUseCase: any LoadSearchAlbumsUseCaseProtocol
  
  // MARK: Initializers
  init(
    loadUseCase: any LoadAlbumsUseCaseProtocol,
    loadSearchPhotosUseCase: any LoadSearchAlbumsUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.loadUseCase = loadUseCase
    self.loadSearchAlbumsUseCase = loadSearchPhotosUseCase
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
    let result = await loadSearchAlbumsUseCase.execute(with: searchTerm)
    updateStateUI(with: result)
  }
  
  override func updateStateUI(with result: Result<[Album], any Error>) {
    super.updateStateUI(with: result)
    CollectionsItem.albums = self.items.map { CollectionsItem.album ($0) }
  }
}
