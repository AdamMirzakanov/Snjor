//
//  PhotoListCoordinator.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Foundation

final class PhotoListCoordinator: Coordinatable {
  // MARK: - Public Properties
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

  // MARK: - Public Methods
  func start() {
    let controller = factory.makeModule(delegate: self)
    factory.makeTabBarItem(navigation: navigation)
    navigation.pushViewController(controller, animated: true)
  }
}

// MARK: - PhotosCollectionViewControllerDelegate
extension PhotoListCoordinator: PhotoListViewControllerDelegate {
  func didSelect(photo: Photo) {
    // code
    let coordinator = factory.mekePhotoDetailCoordinator(
      photo: photo,
      navigation: navigation,
      overlordCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
}

extension PhotoListCoordinator: OverlordCoordinator { }
