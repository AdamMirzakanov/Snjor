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
  var onPhotosChange: (([Photo]) -> Void)? { get set }
  var photosCount: Int { get }
  func getPhotoItem(at index: Int) -> Photo
  func getPhotoID(at index: Int) -> Photo
}
