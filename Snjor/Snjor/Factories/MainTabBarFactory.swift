//
//  MainTabBarFactory.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

protocol MainTabBarFactoring {
  func makeMainTabBarController() -> UITabBarController
  func makeChildCoordinators() -> [Coordinatable]
}

struct MainTabBarFactory: MainTabBarFactoring {
  // MARK: - Public Methods
  func makeMainTabBarController() -> UITabBarController {
    let mainTabBarController = MainTabBarController()
    return mainTabBarController
  }

  func makeChildCoordinators() -> [Coordinatable] {
    return []
  }
}
