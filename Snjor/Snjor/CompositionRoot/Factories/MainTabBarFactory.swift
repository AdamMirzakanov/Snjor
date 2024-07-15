//
//  MainTabBarFactory.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

protocol MainTabBarFactoryProtocol {
  func makeMainTabBarController() -> UITabBarController
  func makeChildCoordinators() -> [any Coordinatable]
}

struct MainTabBarFactory: MainTabBarFactoryProtocol {

  // MARK: - Internal Methods
  func makeMainTabBarController() -> UITabBarController {
    let mainTabBarController = MainTabBarController()
    return mainTabBarController
  }

  func makeChildCoordinators() -> [any Coordinatable] {
    let photoListCoordinator = makePhotosCoordinator()
    return [photoListCoordinator]
  }

  // MARK: - Private Methods
  private func makePhotosCoordinator() -> any Coordinatable {
    let factory = PhotoListFactory()
    let navigationController = UINavigationController()
    let navigation = Navigation(rootViewController: navigationController)
    let coordinator = PhotoListCoordinator(factory: factory, navigation: navigation)
    return coordinator
  }
}
