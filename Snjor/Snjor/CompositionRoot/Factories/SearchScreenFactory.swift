//
//  SearchScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit
import Combine

protocol SearchScreenFactoryProtocol {
  func makeModule(
    delegate: any PhotoListCollectionViewControllerDelegate
  ) -> UIViewController
//  func makeTabBarItem(navigation: any Navigable)
  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable
}

struct SearchScreenFactory: SearchScreenFactoryProtocol {
  // MARK: - Internal Methods
  func makeModule(
    delegate: any PhotoListCollectionViewControllerDelegate
  ) -> UIViewController {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let repository = LoadPhotoListRepository(
      networkService: networkService
    )
    let loadUseCase = LoadPhotoListUseCase(
      repository: repository
    )
    let viewModel = PhotoListViewModel(
      state: state,
      loadUseCase: loadUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
    let defaultLayout = UICollectionViewLayout()
    let module = SearchScreenViewController(
      viewModel: viewModel,
      delegate: delegate,
      layout: defaultLayout
    )
    let cascadeLayout = MultiColumnCascadeLayout(with: module)
    module.rootView.photoListContainerView.photoListCollectionView.collectionViewLayout = cascadeLayout
    module.rootView.photoListContainerView.photoListCollectionView.showsVerticalScrollIndicator = false
    module.rootView.photoListContainerView.photoListCollectionView.register(
      PhotoListCell.self,
      forCellWithReuseIdentifier: PhotoListCell.reuseID
    )
    module.title = "Discover"
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
