//
//  TopicPhotosCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.08.2024.
//

final class TopicPhotosCoordinator: Coordinatable {
  
  // MARK: - Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  
  // MARK: - Private Properties
  private let factory: any TopicPhotosFactoryProtocol
  private weak var overlordCoordinator: (any ParentCoordinator)?
  
  // MARK: - Initializers
  init(
    factory: any TopicPhotosFactoryProtocol,
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
    navigation.navigationBar.tintColor = .label
//    controller.navigationItem.largeTitleDisplayMode = .never
    
  }
}

extension TopicPhotosCoordinator: TopicPhotosViewControllerDelegate {
  func didSelect(_ photo: Photo) {
    let photoDetailCoordinator = factory.makePhotoDetailCoordinator(
      navigation: navigation,
      photo: photo,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(photoDetailCoordinator)
  }
}

extension TopicPhotosCoordinator: ParentCoordinator { }
