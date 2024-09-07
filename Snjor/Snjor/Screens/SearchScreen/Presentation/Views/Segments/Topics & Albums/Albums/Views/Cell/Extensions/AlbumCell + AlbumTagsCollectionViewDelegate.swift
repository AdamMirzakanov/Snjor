//
//  AlbumCell + AlbumTagsCollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

extension AlbumCell: AlbumTagsCollectionViewDelegate {
  func tagCellDidSelect(_ tag: Tag) {
    delegate?.tagCellDidSelect(tag)
  }
}
