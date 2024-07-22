//
//  TopicsPageCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

final class TopicsPageCoordinator: Coordinatable {
  // MARK: - Internal Properties
  var navigation: any Navigable
  
  // MARK: - Private Properties
  private let factory: any TopicsPageFactoryProtocol
  
  // MARK: - Initializers
  init(
    factory: any TopicsPageFactoryProtocol,
    navigation: any Navigable
  ) {
    self.factory = factory
    self.navigation = navigation
  }
  
  // MARK: - Internal Methods
  func start() {
    let controller = factory.makeModule()
    factory.makeTabBarItem(navigation: navigation)
    navigation.pushViewController(controller, animated: true)
  }
}
