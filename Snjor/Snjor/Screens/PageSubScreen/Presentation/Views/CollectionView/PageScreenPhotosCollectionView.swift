//
//  PageScreenPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 01.08.2024.
//

import UIKit

final class PageScreenPhotosCollectionView: BaseCollectionView {  
  // MARK: Private Methods
  override func cellRegister() {
    register(
      PageScreenPhotoCell.self,
      forCellWithReuseIdentifier: PageScreenPhotoCell.reuseID
    )
  }
}
