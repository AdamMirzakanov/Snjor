//
//  ThirdCell + UserAlbumsCollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.09.2024.
//

import Foundation

extension ThirdCell: UserAlbumsCollectionViewDelegate {
  func collectionViewDidSelectItem(at indexPath: IndexPath) {
    delegate?.thirdCellDidSelectItem(at: indexPath)
  }
}
