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
  // MARK: - Protocol Properties
  var navigation: Navigable

  // MARK: - Public Properties
  var childCoordinators: [Coordinatable] = []

  // MARK: - Private Properties
  private let factory: MainTabBarFactory
  private weak var delegate: MainTabBarCoordinatorDelegate?

  // MARK: - Initializers
  init(
    navigation: Navigable,
    factory: MainTabBarFactory,
    delegate: MainTabBarCoordinatorDelegate
  ) {
    self.navigation = navigation
    self.factory = factory
    self.delegate = delegate
  }

  // MARK: - Protocol Methods
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
