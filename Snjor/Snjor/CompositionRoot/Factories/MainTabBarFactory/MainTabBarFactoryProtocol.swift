//
//  MainTabBarFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

protocol MainTabBarFactoryProtocol {
  func makeMainTabBarController() -> UITabBarController
  func makeChildCoordinators() -> [any Coordinatable]
}
