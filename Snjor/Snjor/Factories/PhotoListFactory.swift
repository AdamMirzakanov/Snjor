//
//  PhotoListFactory.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit
import Combine

protocol PhotoListFactoryProtocol {
  func makeModule(delegate: any PhotoListViewControllerDelegate) -> UIViewController
  func makeTabBarItem(navigation: any Navigable)
  func mekePhotoDetailCoordinator(
    id: String,
    navigation: any Navigable,
    overlordCoordinator: any OverlordCoordinator
  ) -> any Coordinatable
}

struct PhotoListFactory: PhotoListFactoryProtocol {
  // MARK: - Public Properties
 let appContainer: any AppContainerProtocol

  // MARK: - Public Methods
  func makeModule(
    delegate: any PhotoListViewControllerDelegate
  ) -> UIViewController {
    let state = PassthroughSubject<StateController, Never>()
    let photoRepository = PhotosRepository(apiClient: appContainer.apiClient)
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let loadPhotoListUseCase = LoadPhotoListUseCase(
      photoListRepository: photoRepository
    )
    let imageDataUseCase = appContainer.getDataImageUseCase()
    let viewModel = PhotoListViewModel(
      state: state,
      loadPhotosUseCase: loadPhotoListUseCase,
      pagingGenerator: lastPageValidationUseCase, 
      imageDataUseCase: imageDataUseCase
    )

    let defaultLayout = UICollectionViewLayout()
    let module = PhotoListCollectionViewController(
      viewModel: viewModel,
      delegate: delegate,
      layout: defaultLayout
    )
    let waterfallLayout = WaterfallLayout(with: module)
    module.collectionView.collectionViewLayout = waterfallLayout
    module.collectionView.showsVerticalScrollIndicator = false
    module.collectionView.register(
      PhotoCell.self,
      forCellWithReuseIdentifier: PhotoCell.reuseID
    )
    return module
  }

  func makeTabBarItem(navigation: any Navigable) {
    makeTabBarItem(
      navigation: navigation,
      title: "News",
      systemImageName: "photo.on.rectangle",
      selectedSystemImageName: "photo.fill.on.rectangle.fill"
    )
  }

  func mekePhotoDetailCoordinator(
    id: String,
    navigation: any Navigable,
    overlordCoordinator: any OverlordCoordinator
  ) -> any Coordinatable {
    let factory = PhotoDetailFactory(id: id, appContainer: appContainer)
    let coordinator = PhotoDetailCoordinator(
      factory: factory,
      navigation: navigation,
      overlordCoordinator: overlordCoordinator
    )
    return coordinator
  }
}

// MARK: - TabBarItemFactory
extension PhotoListFactory: TabBarItemFactory { }
