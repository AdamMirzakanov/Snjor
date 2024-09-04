//
//  PageScreenFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

protocol PageScreenFactoryProtocol {
  func makeController(
    delegate: any PageScreenPhotosDelegate
  ) -> UIViewController
  func makePhotoDetailCoordinator(
    navigation: Navigable,
    photo: Photo,
    parentCoordinator: ParentCoordinator
  ) -> Coordinatable
}
