//
//  SearchScreenViewController + AlbumCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension SearchScreenViewController: AlbumCellDelegate {
  func tagCellDidSelect(_ tag: Tag) {
    let searchTerm = tag.title
    delegate?.searchButtonClicked(
      with: searchTerm,
      currentScopeIndex: currentScopeIndex
    )
  }
}
