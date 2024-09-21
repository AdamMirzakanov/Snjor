//
//  UserProfileFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

import UIKit

protocol UserProfileFactoryProtocol {
  func makeController(
    delegate: any UserProfileViewControllerDelegate
  ) -> UIViewController
  
  func makePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable
  
  func makeAlbumPhotosCoordinator(
    album: Album,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable
}
