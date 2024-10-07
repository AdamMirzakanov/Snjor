//
//  SecondCell + UserPhotosCollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

import Foundation

extension SecondCell: UserPhotosCollectionViewDelegate {
  func collectionViewDidSelectItem(at indexPath: IndexPath) {
    delegate?.secondCellDidSelectItem(at: indexPath)
  }
}
