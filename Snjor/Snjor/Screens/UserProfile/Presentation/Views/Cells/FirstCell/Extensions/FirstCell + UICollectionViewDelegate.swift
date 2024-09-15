//
//  FirstCell + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.09.2024.
//

import UIKit

extension FirstCell: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(
      width: collectionView.frame.width - 20,
      height: 100
    )
  }
}

extension FirstCell: UICollectionViewDelegate { }
