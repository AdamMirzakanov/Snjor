//
//  SearchResultViewController + AlbumCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension SearchResultViewController: AlbumCellDelegate {
  func tagCellDidSelect(_ tag: Tag) {
    let searchTerm = tag.title
    delegate?.tagCellDidSelect(
      tag,
      with: searchTerm,
      currentScopeIndex: .topicAndAlbums
    )
  }
}
