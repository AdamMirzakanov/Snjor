//
//  SearchScreenCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

final class SearchScreenCoordinator: Coordinatable {
  // MARK: - Internal Properties
  var navigation: any Navigable
  
  // MARK: - Private Properties
  private let factory: any SearchScreenFactoryProtocol
  
  // MARK: - Initializers
  init(
    factory: any SearchScreenFactoryProtocol,
    navigation: any Navigable
  ) {
    self.factory = factory
    self.navigation = navigation
  }
  
  // MARK: - Internal Methods
  func start() {
    let controller = factory.makeModule()
//    factory.makeTabBarItem(navigation: navigation)
    navigation.pushViewController(controller, animated: true)
  }
}
