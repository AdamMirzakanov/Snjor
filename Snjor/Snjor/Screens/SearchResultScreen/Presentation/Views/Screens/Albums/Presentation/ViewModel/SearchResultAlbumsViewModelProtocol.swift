//
//  SearchResultAlbumsViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

protocol SearchResultAlbumsViewModelProtocol: BaseViewModelProtocol {
  var albums: [Album] { get }
  func getAlbum(at index: Int) -> Album
  func getAlbumsViewModelItem(at index: Int) -> SearchResultAlbumsViewModelItem
  func loadSearchAlbums(with searchTerm: String)
  func checkAndLoadMoreAlbums(at index: Int)
}
