//
//  AppFactory.swift
//  Snjor
//
//  Created by Адам on 17.05.2024.
//

protocol AppFactoring {
  func makeMainTabBarCoordinator(
    _ navigation: Navigable,
    delegate: MainTabBarCoordinatorDelegate
  ) -> Coordinatable
}

struct AppFactory: AppFactoring {
  // MARK: - Public Methods
  func makeMainTabBarCoordinator(
    _ navigation: Navigable,
    delegate: MainTabBarCoordinatorDelegate
  ) -> Coordinatable {
    let factory = MainTabBarFactory()
    let coordinator = MainTabBarCoordinator(
      navigation: navigation,
      factory: factory,
      delegate: delegate
    )
    return coordinator
  }
}
