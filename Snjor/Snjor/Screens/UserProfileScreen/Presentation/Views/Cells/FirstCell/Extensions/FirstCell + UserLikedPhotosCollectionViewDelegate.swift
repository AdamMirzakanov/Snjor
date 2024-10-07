//
//  FirstCell + UserLikedPhotosCollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

import Foundation

extension FirstCell: UserLikedPhotosCollectionViewDelegate {
  func collectionViewDidSelectItem(at indexPath: IndexPath) {
    delegate?.firstCellDidSelectItem(at: indexPath)
  }
}
