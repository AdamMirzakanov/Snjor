//
//  UserProfileViewController + FirstCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

import Foundation

extension UserProfileViewController: FirstCellDelegate {
  func firstCellDidSelectItem(at indexPath: IndexPath) {
    let photo = userLikedPhotosViewModel.getItem(at: indexPath.item)
    delegate?.didSelectLikedPhoto(photo)
  }
}

extension UserProfileViewController: SecondCellDelegate {
  func secondCellDidSelectItem(at indexPath: IndexPath) {
    let photo = userPhotosViewModel.getItem(at: indexPath.item)
    delegate?.didSelectLikedPhoto(photo)
  }
}
