//
//  AppFactory.swift
//  Snjor
//
//  Created by Адам on 17.05.2024.
//

struct AppFactory: AppFactoryProtocol {
  func makeMainTabBarCoordinator(_ navigation: any Navigable) -> any Coordinatable {
    let factory = MainTabBarFactory()
    let coordinator = MainTabBarCoordinator(
      navigation: navigation,
      factory: factory
    )
    return coordinator
  }
}
