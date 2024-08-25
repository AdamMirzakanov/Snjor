//
//  SearchResultScreenFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

protocol SearchResultScreenFactoryProtocol {
  func makeModule(
    delegate: any SearchResultScreenViewControllerDelegate
  ) -> UIViewController
  
  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable
  
  func mekeAlbumPhotosCoordinator(
    album: Album,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable
}
