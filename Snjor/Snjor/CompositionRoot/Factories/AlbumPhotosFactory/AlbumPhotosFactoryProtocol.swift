//
//  AlbumPhotosFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

protocol AlbumPhotosFactoryProtocol {
  func makeController(
    delegate: any AlbumPhotosViewControllerDelegate
  ) -> UIViewController
  
  func makePhotoDetailCoordinator(
    navigation: Navigable,
    photo: Photo,
    parentCoordinator: ParentCoordinator
  ) -> Coordinatable
}
