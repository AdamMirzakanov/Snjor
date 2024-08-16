//
//  PageScreenTopicPhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 28.07.2024.
//

import UIKit

protocol PageScreenTopicPhotosViewModelProtocol: BaseViewModelProtocol {
//  var photosCount: Int { get }
  func getTopicPhotoListViewModelItem(at index: Int) -> PageScreenTopicPhotosViewModelItem
  func getPhoto(at index: Int) -> Photo
  func applySnapshot()
  func createDataSource(for collectionView: UICollectionView)
}
