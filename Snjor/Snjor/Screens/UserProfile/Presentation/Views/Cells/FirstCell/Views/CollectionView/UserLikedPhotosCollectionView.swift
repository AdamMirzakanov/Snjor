//
//  UserLikedPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.09.2024.
//

import UIKit

final class UserLikedPhotosCollectionView: MainCollectionView {
  // MARK: Internal Methods
  override func cellRegister() {
    register(
      UserLikedPhotoCell.self,
      forCellWithReuseIdentifier: UserLikedPhotoCell.reuseID
    )
  }
}
