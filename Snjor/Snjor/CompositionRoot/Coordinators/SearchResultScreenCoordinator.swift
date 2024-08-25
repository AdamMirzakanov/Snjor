//
//  SearchResultScreenCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 24.08.2024.
//

protocol SearchResultScreenCoordinatorDelegate: AnyObject {
  func didFinish(childCoordinator: any Coordinatable)
}

final class SearchResultScreenCoordinator: Coordinatable {
  // MARK: - Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  private weak var delegate: (any SearchResultScreenCoordinatorDelegate)?
  
  // MARK: - Private Properties
  private let factory: any SearchResultScreenFactoryProtocol
  
  // MARK: - Initializers
  init(
    factory: any SearchResultScreenFactoryProtocol,
    navigation: any Navigable,
    delegate: any SearchResultScreenCoordinatorDelegate
  ) {
    self.factory = factory
    self.navigation = navigation
    self.delegate = delegate
  }
   
  // MARK: - Internal Methods
  func start() {
    let controller = factory.makeModule(delegate: self)
    navigation.viewControllers = [controller]
  }
}

extension SearchResultScreenCoordinator: SearchResultScreenViewControllerDelegate {
  func didFinishFlow() {
    delegate?.didFinish(childCoordinator: self)
  }
  
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
