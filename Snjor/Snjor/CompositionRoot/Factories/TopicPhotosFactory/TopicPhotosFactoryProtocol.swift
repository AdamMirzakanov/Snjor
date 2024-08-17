//
//  TopicPhotosFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

protocol TopicPhotosFactoryProtocol {
  func makeModule(
    delegate: any TopicPhotosViewControllerDelegate
  ) -> UIViewController
  
  func makePhotoDetailCoordinator(
    navigation: Navigable,
    photo: Photo,
    parentCoordinator: ParentCoordinator
  ) -> Coordinatable
}
