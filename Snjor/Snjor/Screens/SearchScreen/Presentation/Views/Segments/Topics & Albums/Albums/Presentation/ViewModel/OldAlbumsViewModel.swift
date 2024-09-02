//
//  OldAlbumsViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import Combine

final class OldAlbumsViewModel: OldAlbumsViewModelProtocol {
  
  // MARK: - Internal Properties
  var albumsCount: Int { albums.count }
  
  // MARK: - Private Properties
  private(set) var state: PassthroughSubject<StateController, Never>
  private let loadUseCase: any LoadAlbumsUseCaseProtocol
  private let loadSearchAlbumsUseCase: any LoadSearchAlbumsUseCaseProtocol
  private var lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  var albums: [Album] = []
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadSearchAlbumsUseCase: any LoadSearchAlbumsUseCaseProtocol,
    loadUseCase: any LoadAlbumsUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  ) {
    self.state = state
    self.loadSearchAlbumsUseCase = loadSearchAlbumsUseCase
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
  
  func getAlbum(at index: Int) -> Album {
    albums[index]
  }
  
  func getAlbumsViewModelItem(
    at index: Int
  ) -> OldAlbumsViewModelItem {
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
  private func makeAlbumListViewModelItem(at index: Int) -> OldAlbumsViewModelItem {
    let album = albums[index]
    return OldAlbumsViewModelItem(album: album)
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
      CollectionsItem.albums = self.albums.map { CollectionsItem.album($0) }
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
  
  
  func checkAndLoadMoreSearchAlbums(at index: Int, with searchTerm: String) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: albums.count,
      action: { self.loadSearchAlbums(with: searchTerm) }
    )
  }
  
  func loadSearchAlbums(with searchTerm: String) {
    state.send(.loading)
    Task {
      await loadSearchAlbumsUseCase(with: searchTerm)
    }
  }
  
  func getSearchAlbumsViewModelItem(
    at index: Int,
    with searchTerm: String
  ) -> OldAlbumsViewModelItem {
    checkAndLoadMoreSearchAlbums(at: index, with: searchTerm)
    return makeAlbumListViewModelItem(at: index)
  }
  
  private func loadSearchAlbumsUseCase(with searchTerm: String) async {
    let result = await loadSearchAlbumsUseCase.execute(with: searchTerm)
    updateStateUI(with: result)
  }
}
