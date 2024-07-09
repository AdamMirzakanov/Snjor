//
//  PhotoDetailCoordinator.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import Foundation

final class PhotoDetailCoordinator: Coordinatable {
  // MARK: - Internal Properties
  var navigation: any Navigable

  // MARK: - Private Properties
  private let factory: any PhotoDetailFactoryProtocol
  private weak var overlordCoordinator: (any ParentCoordinator)?

  // MARK: - Initializers
  init(
    factory: any PhotoDetailFactoryProtocol,
    navigation: any Navigable,
    overlordCoordinator: (any ParentCoordinator)?
  ) {
    self.factory = factory
    self.navigation = navigation
    self.overlordCoordinator = overlordCoordinator
  }

  // MARK: - Internal Methods
  func start() {
    let controller = factory.makeModule()
    navigation.pushViewController(controller, animated: true) { [weak self] in
      guard let self = self else { return }
      self.overlordCoordinator?.removeChildCoordinator(self)
    }
  }
}
