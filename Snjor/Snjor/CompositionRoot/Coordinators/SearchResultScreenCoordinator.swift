//
//  SearchResultScreenCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 24.08.2024.
//

final class SearchResultScreenCoordinator: Coordinatable {
  
  // MARK: Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  
  // MARK: Private Properties
  private let factory: any SearchResultScreenFactoryProtocol
  private weak var parentCoordinator: (any ParentCoordinator)?
  
  // MARK: Initializers
  init(
    factory: any SearchResultScreenFactoryProtocol,
    navigation: any Navigable,
    parentCoordinator: (any ParentCoordinator)?
  ) {
    self.factory = factory
    self.navigation = navigation
    self.parentCoordinator = parentCoordinator
  }
   
  // MARK: Internal Methods
  func start() {
    let controller = factory.makeController(delegate: self)
    navigation.pushViewController(controller, animated: true) { [weak self] in
      guard let self = self else { return }
      self.parentCoordinator?.removeChildCoordinator(self)
    }
  }
}

// MARK: - SearchResultViewControllerDelegate
extension SearchResultScreenCoordinator: SearchResultViewControllerDelegate {
  
  func searchPhotoCellDidSelect(_ photo: Photo) {
    let coordinator = factory.mekePhotoDetailCoordinator(
      photo: photo,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }

  func searchAlbumcCellDidSelect(_ album: Album) {
    let coordinator = factory.mekeAlbumPhotosCoordinator(
      album: album,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func tagCellDidSelect(
    _ tag: Tag,
    with searchTerm: String,
    currentScopeIndex: Int
  ) {
    let coordinator = factory.makeSearchResultScreenCoordinator(
      currentScopeIndex: currentScopeIndex,
      with: searchTerm,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
}

// MARK: - ParentCoordinator
extension SearchResultScreenCoordinator: ParentCoordinator { }
