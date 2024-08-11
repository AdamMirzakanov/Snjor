//
//  AlbumsViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

protocol AlbumsViewModelProtocol: BaseViewModelProtocol {
  func getAlbumListViewModelItem(at index: Int) -> AlbumsViewModelItem
  func applySnapshot()
  func createDataSource(for collectionView: UICollectionView)
}
