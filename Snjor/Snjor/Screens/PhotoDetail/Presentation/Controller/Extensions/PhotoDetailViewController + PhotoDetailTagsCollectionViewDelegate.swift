//
//  PhotoDetailViewController + PhotoDetailTagsCollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

extension PhotoDetailViewController: PhotoDetailTagsCollectionViewDelegate {
  func tagCellDidSelect(_ tag: Tag) {
    delegate?.tagCellDidSelect(
      tag,
      with: tag.title,
      currentScopeIndex: .zero
    )
  }
}
