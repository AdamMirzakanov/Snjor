//
//  AlbumTagsCollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 06.09.2024.
//

protocol AlbumTagsCollectionViewDelegate: AnyObject {
  func tagCellDidSelect(_ tag: Tag)
}
