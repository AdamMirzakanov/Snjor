//
//  PageScreenCoordinator + PageScreenPhotosViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension PageScreenCoordinator: PageScreenPhotosViewControllerDelegate {
  func didSelectCell(_ photo: Photo) {
    let photoDetailCoordinator = factory.makePhotoDetailCoordinator(
      navigation: navigation,
      photo: photo,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(photoDetailCoordinator)
  }
}
