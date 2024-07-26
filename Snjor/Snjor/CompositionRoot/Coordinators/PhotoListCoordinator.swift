//
//  PhotoListCoordinator.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

final class PhotoListCoordinator: Coordinatable {
  // MARK: - Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []

  // MARK: - Private Properties
  private let factory: any PhotoListFactoryProtocol

  // MARK: - Initializers
  init(
    factory: any PhotoListFactoryProtocol,
    navigation: any Navigable
  ) {
    self.factory = factory
    self.navigation = navigation
  }

  // MARK: - Internal Methods
  func start() {
    let controller = factory.makeModule(delegate: self)
    factory.makeTabBarItem(navigation: navigation)
    navigation.pushViewController(controller, animated: true) 
  }
}

// MARK: - PhotosCollectionViewControllerDelegate
extension PhotoListCoordinator: PhotoListCollectionViewControllerDelegate {
  func didSelect(_ photo: Photo) {
    let coordinator = factory.mekePhotoDetailCoordinator(
      photo: photo,
      navigation: navigation,
      overlordCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
    print(#function)
  }
}

extension PhotoListCoordinator: ParentCoordinator { }
