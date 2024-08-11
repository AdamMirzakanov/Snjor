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
    let loadPhotosRepository = LoadPhotoListRepository(
      networkService: networkService
    )
    let loadPhotosUseCase = LoadPhotoListUseCase(
      repository: loadPhotosRepository
    )
    let loadAlbumsRepository = LoadAlbumListRepository(networkService: networkService)
    let loadAlbumsUseCase = LoadAlbumListUseCase(repository: loadAlbumsRepository)
    
    let viewModel = SearchScreenViewModel(
      state: state,
      loadPhotosUseCase: loadPhotosUseCase,
      loadAlbumsUseCase: loadAlbumsUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
    let defaultLayout = UICollectionViewLayout()
    let module = SearchScreenViewController(
      viewModel: viewModel,
      delegate: delegate,
      layout: defaultLayout
    )
    let cascadeLayout = MultiColumnCascadeLayout(with: module)
    module.rootView.photoListCollectionView.collectionViewLayout = cascadeLayout
    module.rootView.albumsCollectionView.collectionViewLayout = createAlbumLayout()
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
  
  
  private func createAlbumLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (
      sectionIndex, layoutEnvironment
    ) -> NSCollectionLayoutSection? in

      
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(1)
      )
      
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      item.contentInsets = NSDirectionalEdgeInsets(
        top: 4.0,
        leading: 4.0,
        bottom: 4.0 * 4.0,
        trailing: 4.0
      )
      
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .estimated(300)
      )
      
      let horizontalGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitem: item,
        count: 2
      )
      let verticalGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: groupSize,
        subitems: [horizontalGroup, horizontalGroup]
      )
      
      let section = NSCollectionLayoutSection(group: verticalGroup)
      section.contentInsets = NSDirectionalEdgeInsets(
        top: 4.0,
        leading: 4.0 * 4.0,
        bottom: 0,
        trailing: 4.0 * 4.0
      )
      return section
    }
    return layout
  }
}
