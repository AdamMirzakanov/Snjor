//
//  SearchScreenViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

protocol SearchScreenViewModelProtocol: BaseViewModelProtocol {
  var photosCount: Int { get }
  func getPhoto(at index: Int) -> Photo
  func getPhotoListViewModelItem(at index: Int) -> PhotoListViewModelItem
  func applySnapshot()
  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any PhotoCellDelegate
  )
  
  func getAlbumListViewModelItem(at index: Int) -> AlbumListViewModelItem
  func applyAlbumsSnapshot()
  func createAlbumsDataSource(for collectionView: UICollectionView)
}
