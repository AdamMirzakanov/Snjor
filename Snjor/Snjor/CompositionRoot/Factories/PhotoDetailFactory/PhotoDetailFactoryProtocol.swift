//
//  PhotoDetailFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

protocol PhotoDetailFactoryProtocol {
  func makeController(
    delegate: any PhotoDetailViewControllerDelegate
  ) -> UIViewController
  
  func makeSearchResultScreenCoordinator(
    currentScopeIndex: Int,
    with searchTerm: String,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable
  
  func makeUserProfileCoordinator(
    user: User,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable
}
