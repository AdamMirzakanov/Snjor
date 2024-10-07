//
//  SearchResulAlbumsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 31.08.2024.
//

final class SearchResulAlbumsCollectionView: MainCollectionView {
  override func cellRegister() {
    register(
      AlbumCell.self,
      forCellWithReuseIdentifier: AlbumCell.reuseID
    )
  }
}
