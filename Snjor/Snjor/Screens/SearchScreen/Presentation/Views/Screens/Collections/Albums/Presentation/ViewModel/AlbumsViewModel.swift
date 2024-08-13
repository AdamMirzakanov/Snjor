//
//  AlbumsViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import Combine

final class AlbumsViewModel: AlbumsViewModelProtocol {
  
  // MARK: - Internal Properties
  var albumsCount: Int { albums.count }
  
  // MARK: - Private Properties
  private(set) var state: PassthroughSubject<StateController, Never>
  private let loadUseCase: any LoadAlbumsUseCaseProtocol
  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  var albums: [Album] = []
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadAlbumsUseCaseProtocol,
    lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  ) {
    self.state = state
    self.loadUseCase = loadUseCase
    self.lastPageValidationUseCase = lastPageValidationUseCase
  }
  
  // MARK: - Internal Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadAlbumsUseCase()
    }
  }
  
  func getAlbumsViewModelItem(
    at index: Int
  ) -> AlbumsViewModelItem {
    checkAndLoadMoreAlbums(at: index)
    return makeAlbumListViewModelItem(at: index)
  }
  
  func checkAndLoadMoreAlbums(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: albums.count,
      action: viewDidLoad
    )
  }
  
  // MARK: - Private Methods
  private func makeAlbumListViewModelItem(at index: Int) -> AlbumsViewModelItem {
    let album = albums[index]
    return AlbumsViewModelItem(album: album)
  }
  
  private func loadAlbumsUseCase() async {
    let result = await loadUseCase.execute()
    updateStateUI(with: result)
  }
  
  private func updateStateUI(with result: Result<[Album], Error>) {
    switch result {
    case .success(let albums):
      let existingAlbumIDs = self.albums.map { $0.id }
      let newAlbums = albums.filter { !existingAlbumIDs.contains($0.id) }
      lastPageValidationUseCase.updateLastPage(itemsCount: albums.count)
      self.albums.append(contentsOf: newAlbums)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
