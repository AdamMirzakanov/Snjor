//
//  TopicsPhotosViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import UIKit

protocol TopicsPhotosViewModelProtocol: BaseViewModelProtocol {
  var photosCount: Int { get }

  func getPhoto(at index: Int) -> Photo
  func applySnapshot()
  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any TopicsPhotosCellDelegate
  )
}
