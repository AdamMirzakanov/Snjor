//
//  AppCoordinator.swift
//  Snjor
//
//  Created by Адам on 17.05.2024.
//

import UIKit

final class AppCoordinator: Coordinatable {
  // MARK: - Protocol Properties
  var navigation: Navigable

  // MARK: - Public Properties
  var factory: AppFactoring?
  var childCoordinators: [Coordinatable] = []
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

  // MARK: - Protocol Methods
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
    let mainTabBarCoordinator = factory?.makeMainTabBarCoordinator(
      navigation,
      delegate: self
    )
    addAndStartChildCoordinator(mainTabBarCoordinator)
  }

  private func clearCoordinatorsAndStart() {
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
