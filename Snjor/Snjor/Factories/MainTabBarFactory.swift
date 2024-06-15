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
  // MARK: - Public Methods
  func makeMainTabBarController() -> UITabBarController {
    let mainTabBarController = MainTabBarController()
    return mainTabBarController
  }

  func makeChildCoordinators() -> [any Coordinatable] {
    return []
  }
}
