//
//  AlbumPhotosViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine

final class AlbumPhotosViewModel: ItemsViewModel <Photo> {
  
  private let loadUseCase: any LoadAlbumPhotosUseCaseProtocol
  
  init(
    loadUseCase: any LoadAlbumPhotosUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.loadUseCase = loadUseCase
    super.init(
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  override func loadItemsUseCase() async {
    let result = await loadUseCase.execute()
    updateStateUI(with: result)
  }
}
