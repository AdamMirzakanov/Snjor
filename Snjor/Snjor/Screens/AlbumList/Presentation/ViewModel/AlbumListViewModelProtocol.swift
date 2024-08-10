//
//  AlbumListViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

protocol AlbumListViewModelProtocol: BaseViewModelProtocol {
  func getAlbumListViewModelItem(at index: Int) -> AlbumListViewModelItem
  func applySnapshot()
  func createDataSource(for collectionView: UICollectionView)
}
