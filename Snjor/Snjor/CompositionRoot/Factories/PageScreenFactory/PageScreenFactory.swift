//
//  PageScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit
import Combine

struct PageScreenFactory: PageScreenFactoryProtocol {
  
  private let lastPageValidationUseCase = LastPageValidationUseCase()
  
  // MARK: Internal Methods
  func makeController(
    delegate: any PageScreenPhotosViewControllerDelegate
  ) -> UIViewController {
    let state = PassthroughSubject<StateController, Never>()
    let networkService = NetworkService()
    let repository = LoadTopicsPageRepository(networkService: networkService)
    let loadUseCase = LoadTopicsUseCase(repository: repository)
    let viewModel = TopicsViewModel(
      loadUseCase: loadUseCase,
      state: state
    )
    return PageScreenViewController(viewModel: viewModel, coordinator: delegate)
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
      parentCoordinator: parentCoordinator
    )
    return coordinator
  }
}
