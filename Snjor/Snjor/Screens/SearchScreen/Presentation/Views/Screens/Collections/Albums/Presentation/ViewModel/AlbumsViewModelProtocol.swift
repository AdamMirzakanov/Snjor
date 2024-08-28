//
//  AlbumsViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

protocol AlbumsViewModelProtocol: BaseViewModelProtocol {
  var albums: [Album] { get }
  func getAlbum(at index: Int) -> Album
  func getAlbumsViewModelItem(at index: Int) -> AlbumsViewModelItem
  func checkAndLoadMoreAlbums(at index: Int)
}
