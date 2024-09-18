//
//  UserPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import UIKit

final class UserPhotosCollectionView: MainCollectionView {
  // MARK: Internal Methods
  override func cellRegister() {
    register(
      UserPhotoCell.self,
      forCellWithReuseIdentifier: UserPhotoCell.reuseID
    )
  }
}

