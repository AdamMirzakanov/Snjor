//
//  TopicsPageCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

final class TopicsPageCoordinator: Coordinatable {
  
  // MARK: Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  
  // MARK: Private Properties
  private let factory: any PageScreenFactoryProtocol
  
  // MARK: Initializers
  init(
    factory: any PageScreenFactoryProtocol,
    navigation: any Navigable
  ) {
    self.factory = factory
    self.navigation = navigation
  }
  
  // MARK: Internal Methods
  func start() {
    let controller = factory.makeController(delegate: self)
    navigation.pushViewController(controller, animated: true)
  }
}

// MARK: - PageScreenPhotosDelegate
extension TopicsPageCoordinator: PageScreenPhotosDelegate {
  func didSelect(_ photo: Photo) {
    let photoDetailCoordinator = factory.makePhotoDetailCoordinator(
      navigation: navigation,
      photo: photo,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(photoDetailCoordinator)
  }
}

// MARK: - ParentCoordinator
extension TopicsPageCoordinator: ParentCoordinator { }
