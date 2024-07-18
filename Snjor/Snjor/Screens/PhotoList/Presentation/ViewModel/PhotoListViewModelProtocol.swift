//
//  PhotoListViewModelProtocol.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol PhotoListViewModelProtocol: BaseViewModelProtocol {
  var photosCount: Int { get }

  func getPhoto(at index: Int) -> Photo
  func applySnapshot()
  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any PhotoListCellDelegate
  )
}
