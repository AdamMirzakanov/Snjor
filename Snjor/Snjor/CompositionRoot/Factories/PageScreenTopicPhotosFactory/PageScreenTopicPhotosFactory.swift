//
//  TopicsPhotoListFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

struct PageScreenTopicPhotosFactory: PageScreenTopicPhotosFactoryProtocol {
  
  // MARK: - Internal Properties
  let topic: Topic
  
  // MARK: - Internal Methods
  func makeModule(
    delegate: any PageScreenPhotosDelegate
  ) -> UIViewController {
    let viewModel = createViewModel()
    let module = createViewController(viewModel: viewModel, delegate: delegate)
    configureLayout(for: module)
    return module
  }
  
  // MARK: - Private Methods
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
    delegate: any PageScreenPhotosDelegate
  ) -> PageScreenPhotosViewController {
    let defaultLayout = UICollectionViewLayout()
    let module = PageScreenPhotosViewController(
      viewModel: viewModel,
      delegate: delegate,
      layout: defaultLayout
    )
    module.rootView.pageScreenPhotosCollectionView.showsVerticalScrollIndicator = false
    return module
  }
  
  private func configureLayout(
    for module: PageScreenPhotosViewController
  ) {
    let cascadeLayout = SingleColumnCascadeLayout(with: module)
    module.rootView.pageScreenPhotosCollectionView.collectionViewLayout = cascadeLayout
  }
}
