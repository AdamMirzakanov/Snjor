//
//  AppCoordinator.swift
//  Snjor
//
//  Created by Адам on 17.05.2024.
//

import UIKit

final class AppCoordinator: Coordinatable {
  // MARK: - Public Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  var factory: (any AppFactoryProtocol)?
  var window: UIWindow?

  // MARK: - Initializers
  init(
    navigation: any Navigable,
    window: UIWindow?,
    factory: (any AppFactoryProtocol)?
  ) {
    self.navigation = navigation
    self.window = window
    self.factory = factory
  }

  // MARK: - Public Methods
  func start() {
    configWindow()
    startSomeCoordinator()
  }

  // MARK: - Private Methods
  private func configWindow() {
    window?.rootViewController = navigation.rootViewController
    window?.makeKeyAndVisible()
  }

  private func startSomeCoordinator() {
    startMainTabBarCoordinator()
  }

  private func startMainTabBarCoordinator() {
    let mainTabBarCoordinator = factory?.makeMainTabBarCoordinator(navigation)
    addAndStartChildCoordinator(mainTabBarCoordinator)
  }

  private func clearCoordinatorsAndStart() {
    navigation.viewControllers = []
    clearAllChildCoordinators()
    startSomeCoordinator()
  }
}

// MARK: - OverlordCoordinator
extension AppCoordinator: OverlordCoordinator { }
