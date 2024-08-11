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
    let module = getModule(delegate)
    return module
  }
  
  func mekePhotoDetailCoordinator(
    photo: Photo,
    navigation: any Navigable,
    overlordCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = PhotoDetailFactory(photo: photo)
    return PhotoDetailCoordinator(
      factory: factory,
      navigation: navigation,
      overlordCoordinator: overlordCoordinator
    )
  }
  
  // MARK: - Private Methods
  private func getModule(
    _ delegate: any PhotoListCollectionViewControllerDelegate
  ) -> UIViewController {
    let viewModel = getViewModel()
    let module = SearchScreenViewController(viewModel: viewModel, delegate: delegate)
    setupLayouts(module: module)
    return module
  }
  
  private func getViewModel() -> SearchScreenViewModel {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let loadPhotosUseCase = getLoadPhotosUseCase(networkService)
    let loadAlbumsUseCase = getLoadAlbumsUseCase(networkService)
    return SearchScreenViewModel(
      state: state,
      loadPhotosUseCase: loadPhotosUseCase,
      loadAlbumsUseCase: loadAlbumsUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
  }
  
  private func getLoadPhotosUseCase(
    _ networkService: NetworkService
  ) -> LoadPhotoListUseCase {
    let loadPhotosRepository = LoadPhotoListRepository(networkService: networkService)
    return LoadPhotoListUseCase(repository: loadPhotosRepository)
  }
  
  private func getLoadAlbumsUseCase(
    _ networkService: NetworkService
  ) -> LoadAlbumListUseCase {
    let loadAlbumsRepository = LoadAlbumListRepository(networkService: networkService)
    return LoadAlbumListUseCase(repository: loadAlbumsRepository)
  }
  
  private func setupLayouts(module: SearchScreenViewController) {
    let cascadeLayout = MultiColumnCascadeLayout(with: module)
    module.rootView.photoListCollectionView.collectionViewLayout = cascadeLayout
    module.rootView.albumsCollectionView.collectionViewLayout = createAlbumLayout()
  }
  
  // MARK: - Create Album Layout
  private func createAlbumLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (
      sectionIndex, layoutEnvironment
    ) -> NSCollectionLayoutSection? in
      let item = makeItem()
      let verticalGroup = makeVerticalGroup(item: item)
      let section = makeSection(group: verticalGroup)
      return section
    }
    return layout
  }
  
  private func makeItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(
      top: 0,
      leading: 4.0,
      bottom: 4.0 * 2.0,
      trailing: 4.0
    )
    return item
  }
  
  private func makeVerticalGroup(
    item: NSCollectionLayoutItem
  ) -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalWidth(0.5)
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
    return verticalGroup
  }
  
  private func makeSection(group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(
      top: 0,
      leading: 4.0 * 4.0,
      bottom: 0,
      trailing: 4.0 * 4.0
    )
    return section
  }
}
