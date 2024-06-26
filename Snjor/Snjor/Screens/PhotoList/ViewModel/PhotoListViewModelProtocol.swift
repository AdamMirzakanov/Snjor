//
//  PhotoListViewModelProtocol.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol PhotoListViewModelProtocol: BaseViewModelProtocol {
  var dataSource: UICollectionViewDiffableDataSource<Section, Photo>? { get set }
  var refreshControl: UIRefreshControl { get }
  func fetchPhoto(at indexPath: IndexPath) -> Photo
  func applySnapshot()
  func createDataSource(for collectionView: UICollectionView)
  func getUrlDetail(itemIndex: Int) -> URL
  func getPhotoListViewModelItem(at indexPath: IndexPath) -> PhotoListViewModelItem
  //  func setupRefreshControl(for collectionView: UICollectionView)
}
