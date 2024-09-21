//
//  UserAlbumsCollectionView + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.09.2024.
//

import UIKit

extension UserAlbumsCollectionView: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    userAlbumsDelegate?.collectionViewDidSelectItem(at: indexPath)
  }
}
