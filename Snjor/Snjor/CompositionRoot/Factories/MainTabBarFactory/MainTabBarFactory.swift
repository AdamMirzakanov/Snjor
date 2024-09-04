//
//  MainTabBarFactory.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

struct MainTabBarFactory: MainTabBarFactoryProtocol {

  // MARK: - Internal Methods
  func makeMainTabBarController() -> UITabBarController {
    let mainTabBarController = MainTabBarController()
    return mainTabBarController
  }

  func makeChildCoordinators() -> [any Coordinatable] {
    let topicsPageCoordinator = makeTopicsPageCoordinator()
    let searchScreenCoordinator = makeSearchScreenCoordinator()
    return [
//      topicsPageCoordinator,
      searchScreenCoordinator,
      
    ]
  }

  // MARK: - Private Methods
  private func makeTopicsPageCoordinator() -> any Coordinatable {
    let factory = PageScreenFactory()
    let navigationController = UINavigationController()
    let navigation = Navigation(rootViewController: navigationController)
    let coordinator = TopicsPageCoordinator(
      factory: factory,
      navigation: navigation)
    return coordinator
  }
  
  private func makeSearchScreenCoordinator() -> any Coordinatable {
    let factory = SearchScreenFactory()
    let navigationController = UINavigationController()
    let navigation = Navigation(rootViewController: navigationController)
    let coordinator = SearchScreenCoordinator(
      factory: factory,
      navigation: navigation
    )
    return coordinator
  }
}
