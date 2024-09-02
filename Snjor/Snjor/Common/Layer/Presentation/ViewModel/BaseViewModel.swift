//
//  BaseViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine
import Foundation

// MARK: - Protocol
protocol BaseViewModelProtocol {
  var state: PassthroughSubject <StateController, Never> { get }
  func viewDidLoad()
}

protocol ContentManagingProtocol <Item> : BaseViewModelProtocol {
  associatedtype Item: ViewModelItemRepresentable, Downloadable
  var items: [Item] { get }
  func getItem(at index: Int) -> Item
  func getViewModelItem(at index: Int) -> ViewModelItem <Item>
  func loadItemsUseCase() async
}

protocol ViewModelItemRepresentable {
  var regularURL: URL? { get }
  var id: String { get }
  var title: String { get }
}

// MARK: - Class
class BaseViewModel <Element: ViewModelItemRepresentable & Downloadable> : ContentManagingProtocol {
  
  typealias Item = Element
  
  // MARK: Internal Properties
  var items: [Element] = []
  var lastPageValidationUseCase: any LastPageValidationUseCaseProtocol
  var state: PassthroughSubject<StateController, Never>
  
  // MARK: Initializers
  init(
    lastPageValidationUseCase: any LastPageValidationUseCaseProtocol,
    state: PassthroughSubject<StateController, Never>
  ) {
    self.lastPageValidationUseCase = lastPageValidationUseCase
    self.state = state
  }
  
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadItemsUseCase()
    }
  }
  
  // MARK: Internal Methods
  func getItem(at index: Int) -> Element {
    items[index]
  }
  
  func getViewModelItem(at index: Int) -> ViewModelItem <Element> {
    checkAndLoadMoreItems(at: index)
    return makeViewModelItem(at: index)
  }
  
  func loadItemsUseCase() async {
    fatalError("This method must be overridden in a subclass")
  }
  
  func updateStateUI(with result: Result<[Element], Error>) {
    switch result {
    case .success(let photos):
      let existingPhotoIDs = self.items.map { $0.id }
      let newPhotos = photos.filter { !existingPhotoIDs.contains($0.id) }
      lastPageValidationUseCase.updateLastPage(itemsCount: photos.count)
      self.items.append(contentsOf: newPhotos)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
  
  // MARK: Private Methods
  func makeViewModelItem(at index: Int) -> ViewModelItem <Element> {
    let photo = items[index]
    return ViewModelItem(item: photo)
  }
  
  func checkAndLoadMoreItems(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: items.count,
      action: viewDidLoad
    )
  }
}

struct ViewModelItem <T: ViewModelItemRepresentable & Downloadable> {

  private(set) var item: T
  
  var itemTitle: String { item.title }
  var itemID: String { item.id }
  var photoURL: URL? { item.regularURL }
}

