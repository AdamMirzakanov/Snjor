//
//  SearchScreenCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

final class SearchScreenCoordinator: Coordinatable {
 
  // MARK: Internal Properties
  var navigation: any Navigable
  var childCoordinators: [any Coordinatable] = []
  
  // MARK: Private Properties
  private let factory: any SearchScreenFactoryProtocol
  
  // MARK: Initializers
  init(
    factory: any SearchScreenFactoryProtocol,
    navigation: any Navigable
  ) {
    self.factory = factory
    self.navigation = navigation
  }
  
  // MARK: Internal Methods
  func start() {
    let controller = factory.makeModule(delegate: self)
    navigation.navigationBar.prefersLargeTitles = true
    navigation.pushViewController(controller, animated: true)
    
  }
}

extension SearchScreenCoordinator: SearchScreenViewControllerDelegate {
  func photoCellDidSelect(_ photo: Photo) {
    let coordinator = factory.mekePhotoDetailCoordinator(
      photo: photo,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func topicCellDidSelect(_ topic: Topic) {
    let coordinator = factory.mekeTopicPhotosCoordinator(
      topic: topic,
      navigation: navigation,
      parentCoordinator: self
    )
    addAndStartChildCoordinator(coordinator)
  }
  
  func albumcCellDidSelect(_ album: Album) {
    let coordinator = factory.mekeAlbumPhotosCoordinator(
      album: album,
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
}

// MARK: - ParentCoordinator
extension SearchScreenCoordinator: ParentCoordinator { }
