//
//  MainTabBarCoordinator.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

final class MainTabBarCoordinator: Coordinatable {
  
  // MARK: Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []

  // MARK: Private Properties
  private let factory: any MainTabBarFactoryProtocol

  // MARK: Initializers
  init(
    navigation: any Navigable,
    factory: any MainTabBarFactoryProtocol
  ) {
    self.navigation = navigation
    self.factory = factory
  }

  // MARK: Internal Methods
  func start() {
    let navigationTabBar = factory.makeMainTabBarController()
    navigation.pushViewController(navigationTabBar, animated: false)
    navigation.navigationBar.isHidden = true
    
    childCoordinators = factory.makeChildCoordinators()
    let childNavigation = childCoordinators.map { $0.navigation.rootViewController }
    childCoordinators.forEach { $0.start() }
    navigationTabBar.viewControllers = childNavigation
  }
}

// MARK: - ParentCoordinator
extension MainTabBarCoordinator: ParentCoordinator { }
