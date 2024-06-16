//
//  PhotoListViewModelProtocol.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol PhotoListViewModelProtocol: BaseViewModelProtocol {
  var dataSource: UICollectionViewDiffableDataSource<Section, Photo>? { get set }
  func fetchPhoto(at indexPath: IndexPath) -> Photo
  func applySnapshot()
  func createDataSource(for collectionView: UICollectionView)
}
