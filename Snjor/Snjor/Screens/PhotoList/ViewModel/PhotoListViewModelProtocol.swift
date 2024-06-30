//
//  PhotoListViewModelProtocol.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol PhotoListViewModelProtocol: BaseViewModelProtocol {
  var refreshControl: UIRefreshControl { get }
  func applySnapshot()
  func createDataSource(for collectionView: UICollectionView)
  // func setupRefreshControl(for collectionView: UICollectionView)

  var photosCount: Int { get }
  var lastPage: Bool { get }
  func getPhotoItem(at index: Int) -> Photo
  func getPhotoListViewModelItem(at index: Int) -> PhotoListViewModelItem
  func getPhotoID(at index: Int) -> Photo
}
