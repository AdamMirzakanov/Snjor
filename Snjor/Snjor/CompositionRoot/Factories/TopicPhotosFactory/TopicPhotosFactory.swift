//
//  TopicsPhotoListFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

struct TopicPhotosFactory: TopicPhotosFactoryProtocol {
  
  // MARK: - Internal Properties
  let topic: Topic
  
  // MARK: - Internal Methods
  func makeModule(
    delegate: any TopicPhotosViewControllerDelegate,
    layoutType: LayoutType
  ) -> UIViewController {
    let viewModel = createViewModel()
    let module = createViewController(viewModel: viewModel, delegate: delegate)
    configureLayout(for: module, layoutType: layoutType)
    return module
  }
  
  // MARK: - Private Methods
  private func createViewModel() -> TopicPhotoListViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let repository = LoadTopicPhotoListRepository(networkService: networkService)
    let loadUseCase = LoadTopicPhotoListUseCase(repository: repository, topic: topic)
    return TopicPhotoListViewModel(
      state: state,
      loadUseCase: loadUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  private func createViewController(
    viewModel: TopicPhotoListViewModel,
    delegate: any TopicPhotosViewControllerDelegate
  ) -> TopicPhotosViewController {
    let defaultLayout = UICollectionViewLayout()
    let module = TopicPhotosViewController(
      viewModel: viewModel,
      delegate: delegate,
      layout: defaultLayout
    )
    module.rootView.topicPhotoListCollectionView.showsVerticalScrollIndicator = false
    return module
  }
  
  private func configureLayout(
    for module: TopicPhotosViewController,
    layoutType: LayoutType
  ) {
    switch layoutType {
    case .singleColumn:
      let cascadeLayout = SingleColumnCascadeLayout(with: module)
      module.rootView.topicPhotoListCollectionView.collectionViewLayout = cascadeLayout
    case .multiColumn:
      let cascadeLayout = MultiColumnCascadeLayout(with: module)
      module.rootView.topicPhotoListCollectionView.collectionViewLayout = cascadeLayout
    }
  }
}

// MARK: - LayoutType
enum LayoutType {
  case singleColumn
  case multiColumn
}
