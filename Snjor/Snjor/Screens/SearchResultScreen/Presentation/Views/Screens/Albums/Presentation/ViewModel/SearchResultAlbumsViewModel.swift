//
//  SearchResultAlbumsViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

import Combine

final class SearchResultAlbumsViewModel: SearchResultAlbumsViewModelProtocol {
  
  // MARK: - Internal Properties
  var albums: [Album] = []
  var searchTerm: String?
  
  // MARK: - Private Properties
  private(set) var state: PassthroughSubject<StateController, Never>
  private let loadUseCase: any LoadSearchAlbumsUseCaseProtocol
  private var lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadSearchAlbumsUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  ) {
    self.state = state
    self.loadUseCase = loadUseCase
    self.lastPageValidationUseCase = lastPageValidationUseCase
  }
  
  // MARK: - Internal Methods
  func viewDidLoad() {
    //code:
  }
  
  func loadSearchAlbums(with searchTerm: String) {
    self.searchTerm = searchTerm // Сохраняем поисковый запрос
    state.send(.loading)
    Task {
      await loadSearchAlbumsUseCase(with: searchTerm)
    }
  }
  
  func getAlbum(at index: Int) -> Album {
    albums[index]
  }
  
  func getAlbumsViewModelItem(
    at index: Int
  ) -> SearchResultAlbumsViewModelItem {
    checkAndLoadMoreAlbums(at: index)
    return makeAlbumListViewModelItem(at: index)
  }
  
  func checkAndLoadMoreAlbums(at index: Int) {
    guard let searchTerm = searchTerm else { return }
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: albums.count,
      action: { self.loadSearchAlbums(with: searchTerm) }
    )
  }
  
  // MARK: - Private Methods
  private func loadSearchAlbumsUseCase(with searchTerm: String) async {
    let result = await loadUseCase.execute(with: searchTerm)
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
  
  private func makeAlbumListViewModelItem(
    at index: Int
  ) -> SearchResultAlbumsViewModelItem {
    let album = albums[index]
    return SearchResultAlbumsViewModelItem(album: album)
  }
}
