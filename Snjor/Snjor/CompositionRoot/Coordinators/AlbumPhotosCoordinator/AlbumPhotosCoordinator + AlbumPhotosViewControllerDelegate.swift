//
//  AlbumPhotosCoordinator + AlbumPhotosViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension AlbumPhotosCoordinator: AlbumPhotosViewControllerDelegate {
  func didSelect(_ photo: Photo) {
    let photoDetailCoordinator = factory.makePhotoDetailCoordinator(
      navigation: navigation,
      photo: photo,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(photoDetailCoordinator)
  }
}
