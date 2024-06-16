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
}

struct PhotoListFactory: PhotoListFactoryProtocol {
  // MARK: - Public Methods
  func makeModule(
    delegate: any PhotoListViewControllerDelegate
  ) -> UIViewController {
    let state = PassthroughSubject<StateController, Never>()
    let apiClient = NetworkService()
    let waterfallPhotoRepository = PhotosRepository(apiClient: apiClient)
    let lastPageValidationUseCase = PagingGenerator()
    let loadWaterfallPhotoUseCase = LoadPhotoListUseCase(
      photoRepository: waterfallPhotoRepository
    )
    let viewModel = PhotosViewModel(
      state: state,
      loadPhotosUseCase: loadWaterfallPhotoUseCase,
      pagingGenerator: lastPageValidationUseCase
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
}

// MARK: - TabBarItemFactory
extension PhotoListFactory: TabBarItemFactory { }
