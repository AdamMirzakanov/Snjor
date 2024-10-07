//
//  UserPhotosCollectionView + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

import UIKit

extension UserPhotosCollectionView: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    userPhotosDelegate?.collectionViewDidSelectItem(at: indexPath)
  }
}
