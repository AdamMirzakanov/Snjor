//
//  MainTabBarCoordinator.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

protocol MainTabBarCoordinatorDelegate: AnyObject {
  func didFinish()
}

final class MainTabBarCoordinator: Coordinatable {
  // MARK: - Public Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []

  // MARK: - Private Properties
  private let factory: any MainTabBarFactoryDeclarable
  private weak var delegate: (any MainTabBarCoordinatorDelegate)?

  // MARK: - Initializers
  init(
    navigation: any Navigable,
    factory: any MainTabBarFactoryDeclarable,
    delegate: any MainTabBarCoordinatorDelegate
  ) {
    self.navigation = navigation
    self.factory = factory
    self.delegate = delegate
  }

  // MARK: - Public Methods
  func start() {
    let navigationTabBar = factory.makeMainTabBarController()
    navigation.pushViewController(navigationTabBar, animated: false)
    navigation.navigationBar.isHidden = true
    childCoordinators = factory.makeChildCoordinators()
    childCoordinators.forEach { $0.start() }
    let childNavigation = childCoordinators.map { $0.navigation.rootViewController }
    navigationTabBar.viewControllers = childNavigation
  }
}

// MARK: - OverlordCoordinator
extension MainTabBarCoordinator: OverlordCoordinator { }
