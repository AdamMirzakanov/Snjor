//
//  UserProfileCoordinator + UserProfileViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

extension UserProfileCoordinator: UserProfileViewControllerDelegate {
  func didSelectUserLikedPhoto(_ photo: Photo) {
    let coordinator = factory.makePhotoDetailCoordinator(
      photo: photo,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func didSelectUserPhoto(_ photo: Photo) {
    let coordinator = factory.makePhotoDetailCoordinator(
      photo: photo,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func didSelectUserAlbum(_ album: Album) {
    let coordinator = factory.makeAlbumPhotosCoordinator(
      album: album,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
}
