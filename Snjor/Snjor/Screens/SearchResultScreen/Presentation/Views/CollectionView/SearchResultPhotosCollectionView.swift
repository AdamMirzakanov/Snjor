//
//  SearchResultPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.10.2024.
//

final class SearchResultPhotosCollectionView: BaseCollectionView {
  override func cellRegister() {
    register(
      SearchResultPhotoCell.self,
      forCellWithReuseIdentifier: SearchResultPhotoCell.reuseID
    )
  }
}
