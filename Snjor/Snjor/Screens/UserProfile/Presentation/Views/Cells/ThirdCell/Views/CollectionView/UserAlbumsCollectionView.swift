//
//  UserAlbumsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

final class UserAlbumsCollectionView: MainCollectionView {
  override func cellRegister() {
    register(
      UserAlbumCell.self,
      forCellWithReuseIdentifier: UserAlbumCell.reuseID
    )
  }
}
