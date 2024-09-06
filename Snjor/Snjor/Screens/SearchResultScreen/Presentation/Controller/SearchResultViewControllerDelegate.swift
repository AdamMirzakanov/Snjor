//
//  SearchResultViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

protocol SearchResultViewControllerDelegate: AnyObject {
  func searchPhotoCellDidSelect(_ photo: Photo)
  func searchAlbumcCellDidSelect(_ album: Album)
  func tagCellDidSelect(
    _ tag: Tag,
    with searchTerm: String,
    currentScopeIndex: Int
  )
}
