//
//  SearchResultScreenCoordinator + SearchResultViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension SearchResultScreenCoordinator: SearchResultViewControllerDelegate {
  func searchPhotoCellDidSelect(_ photo: Photo) {
    let coordinator = factory.makePhotoDetailCoordinator(
      photo: photo,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }

  func searchAlbumcCellDidSelect(_ album: Album) {
    let coordinator = factory.makeAlbumPhotosCoordinator(
      album: album,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func userRowDidSelect(_ user: User) {
    let coordinator = factory.makeUserProfileCoordinator(
      user: user,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func tagCellDidSelect(
    _ tag: Tag,
    with searchTerm: String,
    currentScopeIndex: Int
  ) {
    let coordinator = factory.makeSearchResultScreenCoordinator(
      currentScopeIndex: currentScopeIndex,
      with: searchTerm,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
}
