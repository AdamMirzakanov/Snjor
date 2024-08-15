//
//  AlbumsViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

protocol AlbumsViewModelProtocol: BaseViewModelProtocol {
  var albums: [Album] { get }
  func getAlbumsViewModelItem(at index: Int) -> AlbumsViewModelItem
  func checkAndLoadMoreAlbums(at index: Int)
}
