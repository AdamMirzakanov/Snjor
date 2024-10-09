//
//  SettingsScreenCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.10.2024.
//

final class SettingsScreenCoordinator: Coordinatable {
  // MARK: Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  
  // MARK: Private Properties
  private(set) var factory: any SettingsScreenFactoryProtocol
  
  // MARK: Initializers
  init(
    factory: any SettingsScreenFactoryProtocol,
    navigation: any Navigable
  ) {
    self.factory = factory
    self.navigation = navigation
  }
  
  // MARK: Internal Methods
  func start() {
    let controller = factory.makeController()
    navigation.navigationBar.prefersLargeTitles = true
    navigation.pushViewController(controller, animated: true)
    
  }
}

