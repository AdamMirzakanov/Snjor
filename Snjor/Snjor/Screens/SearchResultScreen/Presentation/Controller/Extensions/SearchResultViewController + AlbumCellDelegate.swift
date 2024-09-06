//
//  SearchResultViewController + AlbumCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension SearchResultViewController: AlbumCellDelegate {
  func tagCellDidSelect(_ tag: Tag, _ cell: AlbumCell) {
    if let indexPath = rootView.albumsCollectionView.indexPath(for: cell) {
      let searchTerm = tag.title
      delegate?.tagCellDidSelect(
        tag,
        with: searchTerm,
        currentScopeIndex: .topicAndAlbums
      )
      print(#function, Self.self, tag.title)
    }
  }
}
