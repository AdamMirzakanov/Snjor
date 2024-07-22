//
//  TopicsPhotosFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import UIKit
import Combine

protocol TopicsPhotosFactoryProtocol {
  func makeModule(
    delegate: any TopicsPhotosViewControllerDelegate
  ) -> UIViewController
  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable
}

struct TopicsPhotosFactory: TopicsPhotosFactoryProtocol {
  // MARK: - Internal Methods
  func makeModule(
    delegate: any TopicsPhotosViewControllerDelegate
  ) -> UIViewController {
    let apiClient = NetworkService()
    let state = PassthroughSubject<StateController, Never>()
    let photoRepository = TopicsPhotosRepository(apiClient: apiClient)
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let topicsPhotosUseCase = TopicsPhotosUseCase(
      topicsPhotosRepository: photoRepository
    )
    let viewModel = TopicsPhotosViewModel(
      state: state,
      loadTopicPhotosUseCase: topicsPhotosUseCase,
      pagingGenerator: lastPageValidationUseCase
    )

    let defaultLayout = UICollectionViewLayout()
    let module = TopicsPhotosCollectionViewController(
      viewModel: viewModel,
      delegate: delegate,
      layout: defaultLayout
    )
    let cascadeLayout = CascadeLayout(with: module)
    module.collectionView.collectionViewLayout = cascadeLayout
    module.collectionView.showsVerticalScrollIndicator = false
    module.collectionView.register(
      PhotoCell.self,
      forCellWithReuseIdentifier: PhotoCell.reuseID
    )
    return module
  }

  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = PhotoDetailFactory(photo: photo)
    let coordinator = PhotoDetailCoordinator(
      factory: factory,
      navigation: navigation,
      overlordCoordinator: overlordCoordinator
    )
    return coordinator
  }
}
