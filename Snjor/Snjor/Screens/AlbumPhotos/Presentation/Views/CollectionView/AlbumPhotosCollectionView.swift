//
//  AlbumPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

final class AlbumPhotosCollectionView: MainCollectionView {
  override func cellRegister() {
    register(
      AlbumPhotoCell.self,
      forCellWithReuseIdentifier: AlbumPhotoCell.reuseID
    )
  }
}
