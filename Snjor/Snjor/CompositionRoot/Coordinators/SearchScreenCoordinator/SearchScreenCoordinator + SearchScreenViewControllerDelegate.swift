//
//  SearchScreenCoordinator + SearchScreenViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension SearchScreenCoordinator: SearchScreenViewControllerDelegate {
  func photoCellDidSelect(_ photo: Photo) {
    let coordinator = factory.makePhotoDetailCoordinator(
      photo: photo,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func topicCellDidSelect(_ topic: Topic) {
    let coordinator = factory.makeTopicPhotosCoordinator(
      topic: topic,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func albumCellDidSelect(_ album: Album) {
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
  
  func searchButtonClicked(with searchTerm: String, currentScopeIndex: Int) {
    let coordinator = factory.makeSearchResultScreenCoordinator(
      currentScopeIndex: currentScopeIndex,
      with: searchTerm,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func tagCellDidSelect(_ tag: Tag, with searchTerm: String, currentScopeIndex: Int) {
    let coordinator = factory.makeSearchResultScreenCoordinator(
      currentScopeIndex: currentScopeIndex,
      with: searchTerm,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
}
