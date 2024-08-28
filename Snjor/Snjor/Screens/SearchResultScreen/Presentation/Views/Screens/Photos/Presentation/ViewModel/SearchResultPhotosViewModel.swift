//
//  SearchResultPhotosViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import Combine


final class SearchResultPhotosViewModel: SearchResultPhotosViewModelProtocol {

  // MARK: - Internal Properties
  var photos: [Photo] = []
  var searchTerm: String? // Добавлено для хранения поискового запроса

  // MARK: - Private Properties
  private(set) var state: PassthroughSubject<StateController, Never>
  private let loadSearchPhotosUseCase: any LoadSearchPhotosUseCaseProtocol
  private var lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadSearchPhotosUseCase: any LoadSearchPhotosUseCaseProtocol,
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  ) {
    self.state = state
    self.loadSearchPhotosUseCase = loadSearchPhotosUseCase
    self.lastPageValidationUseCase = lastPageValidationUseCase
  }
  
  // MARK: - Internal Methods
  func viewDidLoad() {
    //code:
  }

  func loadSearchPhotos(with searchTerm: String) {
    self.searchTerm = searchTerm // Сохраняем поисковый запрос
    state.send(.loading)
    Task {
      await loadSearchPhotosUseCase(with: searchTerm)
    }
  }

  func getPhoto(at index: Int) -> Photo {
    photos[index]
  }

  func getPhotoListViewModelItem(at index: Int) -> SearchResultPhotosViewModelItem {
    checkAndLoadMorePhotos(at: index)
    return makePhotoListViewModelItem(at: index)
  }

  // Метод реализует пагинацию, подгружая страницы
  func checkAndLoadMorePhotos(at index: Int) {
    guard let searchTerm = searchTerm else { return }
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: { self.loadSearchPhotos(with: searchTerm) }
    )
  }

  // MARK: - Private Methods
  private func loadSearchPhotosUseCase(with searchTerm: String) async {
    let result = await loadSearchPhotosUseCase.execute(with: searchTerm)
    updateStateUI(with: result)
  }

  private func updateStateUI(with result: Result<[Photo], Error>) {
    switch result {
    case .success(let photos):
      let existingPhotoIDs = self.photos.map { $0.id }
      let newPhotos = photos.filter { !existingPhotoIDs.contains($0.id) }
      lastPageValidationUseCase.updateLastPage(itemsCount: photos.count)
      self.photos.append(contentsOf: newPhotos)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }

  private func makePhotoListViewModelItem(at index: Int) -> SearchResultPhotosViewModelItem {
    let photo = photos[index]
    return SearchResultPhotosViewModelItem(photo: photo)
  }
}
