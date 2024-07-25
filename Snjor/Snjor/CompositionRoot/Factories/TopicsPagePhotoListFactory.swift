//
//  TopicsPagePhotoListFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

protocol TopicsPagePhotoListFactoryProtocol {
  func makeModule(
    delegate: any TopicsPagePhotoListViewControllerDelegate
  ) -> UIViewController
//  func makeTabBarItem(navigation: any Navigable)
  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable
}

struct TopicsPagePhotoListFactory: TopicsPagePhotoListFactoryProtocol {
  func makeModule(
    delegate: any TopicsPagePhotoListViewControllerDelegate
  ) -> UIViewController {
    let apiClient = NetworkService()
    let state = PassthroughSubject<StateController, Never>()
    let repository = LoadPageTopicsPhotoListRepository(
      apiClient: apiClient)
    let useCase = LoadTopicsPagePhotoListUseCase(
      topicsPhotoListRepository: repository
    )
    let lastPageValidationUseCase = LastPageValidationUseCase()
    
    let viewModel = TopicsPagePhotoListViewModel(
      state: state,
      loadTopicsPagePhotosUseCase: useCase,
      pagingGenerator: lastPageValidationUseCase
    )
    
    let defaultLayout = UICollectionViewLayout()
    
    let module = TopicsPagePhotoListViewController(
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
  
//  func makeTabBarItem(navigation: any Navigable) {
//    
//  }
  
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
