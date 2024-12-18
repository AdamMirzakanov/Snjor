//
//  AlbumPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

final class AlbumPhotosCollectionView: BaseCollectionView {
  override func cellRegister() {
    register(
      AlbumPhotoCell.self,
      forCellWithReuseIdentifier: AlbumPhotoCell.reuseID
    )
    
    register(
      AlbumPhotosSectionHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: AlbumPhotosSectionHeaderView.reuseID
    )
  }
}
