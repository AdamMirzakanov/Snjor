//
//  PhotoDetailCoordinator + PhotoDetailViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension PhotoDetailCoordinator: PhotoDetailViewControllerDelegate {
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
