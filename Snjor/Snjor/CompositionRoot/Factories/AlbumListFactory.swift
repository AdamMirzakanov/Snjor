//
//  AlbumListFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit
import Combine

protocol AlbumListFactoryProtocol {
  func makeModule() -> UIViewController
}

struct AlbumListFactory: AlbumListFactoryProtocol {
  func makeModule() -> UIViewController {
    let networkService = NetworkService()
    let lastPageValidationUseCase = LastPageValidationUseCase()
    let state = PassthroughSubject<StateController, Never>()
    let defaultLayout = UICollectionViewFlowLayout()
    
    let repository = LoadAlbumListRepository(
      networkService: networkService
    )
    let loadUseCase = LoadAlbumListUseCase(
      repository: repository
    )
    let viewModel = AlbumListViewModel(
      state: state,
      loadUseCase: loadUseCase,
      lastPageValidationUseCase: lastPageValidationUseCase
    )
    
    let module = AlbumsCollectionViewController(
      viewModel: viewModel,
      layout: defaultLayout
    )
    module.collectionView.collectionViewLayout = createLayout()
    module.collectionView.register(
      AlbumCell.self,
      forCellWithReuseIdentifier: AlbumCell.reuseID
    )
    return module
  }
  
  private func createLayout() -> UICollectionViewLayout {
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
