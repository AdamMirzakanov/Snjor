//
//  AlbumTagsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

import UIKit

final class AlbumTagsCollectionView: MainTagsCollectionView {
  
  override func setupDelegate() {
    delegate = self
    dataSource = self
  }
  
  override func cellRegister() {
    register(
      AlbumTagCell.self,
      forCellWithReuseIdentifier: AlbumTagCell.reuseID
    )
  }
}
