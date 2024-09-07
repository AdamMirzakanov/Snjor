//
//  SearchScreenCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

final class SearchScreenCoordinator: Coordinatable {
 
  // MARK: Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  
  // MARK: Private Properties
  private(set) var factory: any SearchScreenFactoryProtocol
  
  // MARK: Initializers
  init(
    factory: any SearchScreenFactoryProtocol,
    navigation: any Navigable
  ) {
    self.factory = factory
    self.navigation = navigation
  }
  
  // MARK: Internal Methods
  func start() {
    let controller = factory.makeController(delegate: self)
    navigation.navigationBar.prefersLargeTitles = true
    navigation.pushViewController(controller, animated: true)
    
  }
}



// MARK: - SearchScreenCoordinator + ParentCoordinator

