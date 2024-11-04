//
//  SearchScreenPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

final class SearchScreenPhotosCollectionView: MainCollectionView {
  override func cellRegister() {
    register(
      SearchScreenPhotoCell.self,
      forCellWithReuseIdentifier: SearchScreenPhotoCell.reuseID
    )
  }
}
