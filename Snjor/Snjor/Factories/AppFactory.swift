//
//  AppFactory.swift
//  Snjor
//
//  Created by Адам on 17.05.2024.
//

protocol AppFactoryProtocol {
  func makeMainTabBarCoordinator(
    _ navigation: any Navigable,
    delegate: MainTabBarCoordinatorDelegate
  ) -> any Coordinatable
}

struct AppFactory: AppFactoryProtocol {
  // MARK: - Public Methods
  func makeMainTabBarCoordinator(
    _ navigation: any Navigable,
    delegate: any MainTabBarCoordinatorDelegate
  ) -> any Coordinatable {
    let factory = MainTabBarFactory()
    let coordinator = MainTabBarCoordinator(
      navigation: navigation,
      factory: factory,
      delegate: delegate
    )
    return coordinator
  }
}
