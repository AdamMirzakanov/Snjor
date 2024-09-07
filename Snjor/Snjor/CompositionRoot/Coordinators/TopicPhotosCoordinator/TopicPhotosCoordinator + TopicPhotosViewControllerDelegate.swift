//
//  TopicPhotosCoordinator + TopicPhotosViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension TopicPhotosCoordinator: TopicPhotosViewControllerDelegate {
  func didSelect(_ photo: Photo) {
    let photoDetailCoordinator = factory.makePhotoDetailCoordinator(
      navigation: navigation,
      photo: photo,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(photoDetailCoordinator)
  }
}
