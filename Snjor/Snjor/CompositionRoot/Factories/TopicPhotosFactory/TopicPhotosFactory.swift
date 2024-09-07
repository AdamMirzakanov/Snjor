//
//  TopicPhotosFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit
import Combine

struct TopicPhotosFactory: TopicPhotosFactoryProtocol {
  // MARK: Internal Properties
  let topic: Topic
  
  // MARK: Internal Methods
  func makeController(
    delegate: any TopicPhotosViewControllerDelegate
  ) -> UIViewController {
    let viewModel = createViewModel()
    let controller = createViewController(viewModel: viewModel, delegate: delegate)
    controller.navigationItem.title = topic.title
    configureLayout(for: controller)
    return controller
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
  
  // MARK: Private Methods
  private func createViewModel() -> TopicPhotosViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let repository = LoadTopicPhotosRepository(networkService: networkService)
    let loadUseCase = LoadTopicPhotosUseCase(repository: repository, topic: topic)
    return TopicPhotosViewModel(
      loadUseCase: loadUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase,
      state: state
    )
  }
  
  private func createViewController(
    viewModel: TopicPhotosViewModel,
    delegate: any TopicPhotosViewControllerDelegate
  ) -> TopicPhotosViewController {
    let defaultLayout = UICollectionViewLayout()
    let controller = TopicPhotosViewController(
      viewModel: viewModel,
      delegate: delegate,
      layout: defaultLayout
    )
    controller.rootView.topicPhotosCollectionView.showsVerticalScrollIndicator = false
    return controller
  }
  
  private func configureLayout(
    for controller: TopicPhotosViewController
  ) {
    let cascadeLayout = MultiColumnCascadeLayout(with: controller)
    controller.rootView.topicPhotosCollectionView.collectionViewLayout = cascadeLayout
  }
}
