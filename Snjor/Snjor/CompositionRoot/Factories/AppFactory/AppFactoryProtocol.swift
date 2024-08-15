//
//  AppFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

protocol AppFactoryProtocol {
  func makeMainTabBarCoordinator(_ navigation: any Navigable) -> any Coordinatable
}
