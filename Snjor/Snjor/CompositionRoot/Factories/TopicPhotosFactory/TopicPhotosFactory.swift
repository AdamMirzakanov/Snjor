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
    delegate: any TopicPhotosViewControllerDelegate
  ) -> UIViewController {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let repository = LoadTopicPhotoListRepository(
      networkService: networkService
    )
    let loadUseCase = LoadTopicPhotoListUseCase(
      repository: repository,
      topic: topic
    )
    let viewModel = TopicPhotoListViewModel(
      state: state,
      loadUseCase: loadUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
    let defaultLayout = UICollectionViewLayout()

    let module = TopicPhotosViewController(
      viewModel: viewModel,
      delegate: delegate,
      layout: defaultLayout
    )

    let cascadeLayout = SingleColumnCascadeLayout(with: module)
    module.rootView.topicPhotoListCollectionView.collectionViewLayout = cascadeLayout
    module.rootView.topicPhotoListCollectionView.showsVerticalScrollIndicator = false
    return module
  }
}
