//
//  AlbumPhotosCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

final class AlbumPhotosCoordinator: Coordinatable {
  
  // MARK: Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  
  // MARK: Private Properties
  private let factory: any AlbumPhotosFactoryProtocol
  private weak var parentCoordinator: (any ParentCoordinator)?
  
  // MARK: Initializers
  init(
    factory: any AlbumPhotosFactoryProtocol,
    navigation: any Navigable,
    parentCoordinator: (any ParentCoordinator)?
  ) {
    self.factory = factory
    self.navigation = navigation
    self.parentCoordinator = parentCoordinator
  }

  // MARK: Internal Methods
  func start() {
    let controller = factory.makeModule(delegate: self)
    navigation.pushViewController(controller, animated: true) { [weak self] in
      guard let self = self else { return }
      self.parentCoordinator?.removeChildCoordinator(self)
    }
    controller.navigationItem.largeTitleDisplayMode = .never
  }
}

// MARK: - AlbumPhotosViewControllerDelegate
extension AlbumPhotosCoordinator: AlbumPhotosViewControllerDelegate {
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
extension AlbumPhotosCoordinator: ParentCoordinator { }
