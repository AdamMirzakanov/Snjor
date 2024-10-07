//
//  UserLikedPhotosCollectionView + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

import UIKit

extension UserLikedPhotosCollectionView: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    likedPhotosDelegate?.collectionViewDidSelectItem(at: indexPath)
  }
}
