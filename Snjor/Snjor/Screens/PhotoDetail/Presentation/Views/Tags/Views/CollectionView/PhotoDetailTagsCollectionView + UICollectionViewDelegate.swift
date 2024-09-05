//
//  PhotoDetailTagsCollectionView + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

import UIKit

extension PhotoDetailTagsCollectionView: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    tagsDelegate?.tagCellDidSelect(tags[indexPath.item])
  }
}
