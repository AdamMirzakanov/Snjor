//
//  PageScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit
import Combine

struct PageScreenFactory: PageScreenFactoryProtocol {
  
  // MARK: - Internal Methods
  func makeTabBarItem(navigation: any Navigable) {
    makeTabBarItem(
      navigation: navigation,
      title: ".photoListTitle",
      systemImageName: ".photoListItemImage",
      selectedSystemImageName: ".photoListSelectedItemImage"
    )
  }
  
  func makeModule(
    delegate: any PageScreenTopicPhotosViewControllerDelegate
  ) -> UIViewController {
    let state = PassthroughSubject<StateController, Never>()
    let networkService = NetworkService()
    let repository = LoadTopicsPageRepository(networkService: networkService)
    let loadUseCase = LoadTopicsUseCase(repository: repository)
    let viewModel = OldTopicsViewModel(state: state, loadUseCase: loadUseCase)
    let module = PageScreenViewController(viewModel: viewModel, coordinator: delegate)
    return module
  }
  
  func makePhotoDetailCoordinator(
    navigation: any Navigable,
    photo: Photo,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = PhotoDetailFactory(photo: photo)
    let coordinator = PhotoDetailCoordinator(
      factory: factory,
      navigation: navigation,
      overlordCoordinator: parentCoordinator
    )
    return coordinator
  }
}

// MARK: - TabBarItemFactory
extension PageScreenFactory: TabBarItemFactory { }
