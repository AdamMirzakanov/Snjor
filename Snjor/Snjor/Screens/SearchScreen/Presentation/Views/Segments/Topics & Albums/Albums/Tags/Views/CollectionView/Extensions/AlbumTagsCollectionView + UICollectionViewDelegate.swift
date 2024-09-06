//
//  AlbumTagsCollectionView + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 06.09.2024.
//

import UIKit

extension AlbumTagsCollectionView: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    tagsDelegate?.tagCellDidSelect(tags[indexPath.item])
  }
}
