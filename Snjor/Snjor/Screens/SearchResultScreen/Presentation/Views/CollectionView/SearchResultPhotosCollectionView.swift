//
//  SearchResultPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.10.2024.
//

final class SearchResultPhotosCollectionView: MainCollectionView {
  override func cellRegister() {
    register(
      SearchResultPhotoCell.self,
      forCellWithReuseIdentifier: SearchResultPhotoCell.reuseID
    )
  }
}
