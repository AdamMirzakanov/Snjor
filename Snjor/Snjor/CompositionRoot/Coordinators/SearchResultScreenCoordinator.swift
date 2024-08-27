//
//  SearchResultScreenCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 24.08.2024.
//

final class SearchResultScreenCoordinator: Coordinatable {
  // MARK: - Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  
  // MARK: - Private Properties
  private let factory: any SearchResultScreenFactoryProtocol
  private weak var overlordCoordinator: (any ParentCoordinator)?
  
  // MARK: - Initializers
  init(
    factory: any SearchResultScreenFactoryProtocol,
    navigation: any Navigable,
    overlordCoordinator: (any ParentCoordinator)?
  ) {
    self.factory = factory
    self.navigation = navigation
    self.overlordCoordinator = overlordCoordinator
  }
   
  // MARK: - Internal Methods
  func start() {
    let controller = factory.makeModule(delegate: self)
    navigation.pushViewController(controller, animated: true) { [weak self] in
      guard let self = self else { return }
      self.overlordCoordinator?.removeChildCoordinator(self)
    }
  }
}

extension SearchResultScreenCoordinator: SearchResultScreenViewControllerDelegate {
  func searchPhotoCellDidSelect(_ photo: Photo) {
    let coordinator = factory.mekePhotoDetailCoordinator(
      photo: photo,
      navigation: navigation,
      overlordCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
//  func topicCellDidSelect(_ topic: Topic) {
//    let coordinator = factory.mekeTopicPhotosCoordinator(
//      topic: topic,
//      navigation: navigation,
//      overlordCoordinator: self
//    )
//    addAndStartChildCoordinator(coordinator)
//  }
//  
//  func albumcCellDidSelect(_ album: Album) {
//    let coordinator = factory.mekeAlbumPhotosCoordinator(
//      album: album,
//      navigation: navigation,
//      overlordCoordinator: self
//    )
//    addAndStartChildCoordinator(coordinator)
//  }
}

// MARK: - ParentCoordinator
extension SearchResultScreenCoordinator: ParentCoordinator { }
