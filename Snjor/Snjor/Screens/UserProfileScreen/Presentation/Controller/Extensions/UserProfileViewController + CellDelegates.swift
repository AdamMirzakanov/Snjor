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
    delegate?.didSelectUserLikedPhoto(photo)
  }
}

extension UserProfileViewController: SecondCellDelegate {
  func secondCellDidSelectItem(at indexPath: IndexPath) {
    let photo = userPhotosViewModel.getItem(at: indexPath.item)
    delegate?.didSelectUserLikedPhoto(photo)
  }
}

extension UserProfileViewController: ThirdCellDelegate {
  func thirdCellDidSelectItem(at indexPath: IndexPath) {
    let album = userAlbumsViewModel.getItem(at: indexPath.item)
    delegate?.didSelectUserAlbum(album)
  }
}
