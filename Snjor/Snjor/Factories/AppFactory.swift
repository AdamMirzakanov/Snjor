//
//  AppFactory.swift
//  Snjor
//
//  Created by Адам on 17.05.2024.
//

protocol AppFactoryProtocol {
  func makeMainTabBarCoordinator(_ navigation: any Navigable) -> any Coordinatable
}

struct AppFactory: AppFactoryProtocol {
  let appContainer = AppContainer()
  // MARK: - Public Methods
  func makeMainTabBarCoordinator(_ navigation: any Navigable) -> any Coordinatable {
    let factory = MainTabBarFactory(appContainer: appContainer)
    let coordinator = MainTabBarCoordinator(
      navigation: navigation,
      factory: factory
    )
    return coordinator
  }
}
