//
//  TopicPhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

protocol TopicPhotosViewModelProtocol: BaseViewModelProtocol {
//  var photosCount: Int { get }
  func getTopicPhotoListViewModelItem(at index: Int) -> PageScreenTopicPhotosViewModelItem
  func getPhoto(at index: Int) -> Photo
  func applySnapshot()
  func createDataSource(for collectionView: UICollectionView)
}
