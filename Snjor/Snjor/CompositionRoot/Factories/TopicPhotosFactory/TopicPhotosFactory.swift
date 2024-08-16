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
    delegate: any PageScreenTopicPhotosViewControllerDelegate,
    layoutType: LayoutType
  ) -> UIViewController {
    let viewModel = createViewModel()
    let module = createViewController(viewModel: viewModel, delegate: delegate)
    configureLayout(for: module, layoutType: layoutType)
    return module
  }
  
  // MARK: - Private Methods
  private func createViewModel() -> PageScreenTopicPhotosViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let repository = LoadTopicPhotosRepository(networkService: networkService)
    let loadUseCase = LoadTopicPhotosUseCase(repository: repository, topic: topic)
    return PageScreenTopicPhotosViewModel(
      state: state,
      loadUseCase: loadUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  private func createViewController(
    viewModel: PageScreenTopicPhotosViewModel,
    delegate: any PageScreenTopicPhotosViewControllerDelegate
  ) -> PageScreenTopicPhotosViewController {
    let defaultLayout = UICollectionViewLayout()
    let module = PageScreenTopicPhotosViewController(
      viewModel: viewModel,
      delegate: delegate,
      layout: defaultLayout
    )
    module.rootView.pageScreenTopicPhotosCollectionView.showsVerticalScrollIndicator = false
    return module
  }
  
  private func configureLayout(
    for module: PageScreenTopicPhotosViewController,
    layoutType: LayoutType
  ) {
    switch layoutType {
    case .singleColumn:
      let cascadeLayout = SingleColumnCascadeLayout(with: module)
      module.rootView.pageScreenTopicPhotosCollectionView.collectionViewLayout = cascadeLayout
    case .multiColumn:
      let cascadeLayout = MultiColumnCascadeLayout(with: module)
      module.rootView.pageScreenTopicPhotosCollectionView.collectionViewLayout = cascadeLayout
    }
  }
}

// MARK: - LayoutType
enum LayoutType {
  case singleColumn
  case multiColumn
}
