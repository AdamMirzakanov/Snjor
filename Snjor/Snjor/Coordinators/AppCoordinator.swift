//
//  AppCoordinator.swift
//  Snjor
//
//  Created by Адам on 17.05.2024.
//

import UIKit

final class AppCoordinator: Coordinatable {
  // MARK: - Public Properties
  var navigation: Navigable
  var childCoordinators: [Coordinatable] = []
  var factory: AppFactoring?
  var window: UIWindow?

  // MARK: - Initializers
  init(
    navigation: Navigable,
    window: UIWindow?,
    factory: AppFactoring?
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
}

// MARK: - Private Methods
private extension AppCoordinator {
  func configWindow() {
    window?.rootViewController = navigation.rootViewController
    window?.makeKeyAndVisible()
  }

  func startSomeCoordinator() {
    startMainTabBarCoordinator()
  }

  func startMainTabBarCoordinator() {
    let mainTabBarCoordinator = factory?.makeMainTabBarCoordinator(
      navigation,
      delegate: self
    )
    addAndStartChildCoordinator(mainTabBarCoordinator)
  }

  func clearCoordinatorsAndStart() {
    navigation.viewControllers = []
    removeAllChildCoordinators()
    startSomeCoordinator()
  }
}

// MARK: - MainTabBarCoordinatorDelegate
extension AppCoordinator: MainTabBarCoordinatorDelegate {
  func didFinish() {
    clearCoordinatorsAndStart()
  }
}

// MARK: - OverlordCoordinator
extension AppCoordinator: OverlordCoordinator { }
