//
//  SearchScreenFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

protocol SearchScreenFactoryProtocol {
  func makeModule(
    delegate: any SearchScreenViewControllerDelegate
  ) -> UIViewController
  
  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable
  
  func mekeTopicPhotosCoordinator(
    topic: Topic,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable
  
  func mekeAlbumPhotosCoordinator(
    album: Album,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable
  
  func makeSearchResultScreenCoordinator(
    currentScopeIndex: Int,
    with searchTerm: String,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable
}
