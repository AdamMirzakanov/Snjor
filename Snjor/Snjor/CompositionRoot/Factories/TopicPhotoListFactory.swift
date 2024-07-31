//
//  TopicsPhotoListFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

protocol TopicPhotoListFactoryProtocol {
  func makeModule(
    delegate: any TopicPhotoListViewControllerDelegate
  ) -> UIViewController
}

struct TopicPhotoListFactory: TopicPhotoListFactoryProtocol {
  
  let topic: Topic
  
  func makeModule(
    delegate: any TopicPhotoListViewControllerDelegate
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

    let module = TopicPhotoListViewController(
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
