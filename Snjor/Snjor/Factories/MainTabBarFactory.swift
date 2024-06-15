//
//  MainTabBarFactory.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

protocol MainTabBarFactoryDeclarable {
  func makeMainTabBarController() -> UITabBarController
  func makeChildCoordinators() -> [any Coordinatable]
}

struct MainTabBarFactory: MainTabBarFactoryDeclarable {
  // MARK: - Public Methods
  func makeMainTabBarController() -> UITabBarController {
    let mainTabBarController = MainTabBarController()
    return mainTabBarController
  }

  func makeChildCoordinators() -> [any Coordinatable] {
    return []
  }
}
