//
//  PageScreenFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

protocol PageScreenFactoryProtocol {
  func makeTabBarItem(navigation: any Navigable)
  func makeModule(
    delegate: any PageScreenPhotosDelegate
  ) -> UIViewController
  func makePhotoDetailCoordinator(
    navigation: Navigable,
    photo: Photo,
    parentCoordinator: ParentCoordinator
  ) -> Coordinatable
}
