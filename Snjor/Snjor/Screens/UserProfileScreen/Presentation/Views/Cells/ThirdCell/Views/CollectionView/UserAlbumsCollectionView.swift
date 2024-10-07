//
//  UserAlbumsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

final class UserAlbumsCollectionView: MainCollectionView {
  // MARK: Internal Properties
  weak var userAlbumsDelegate: (any UserAlbumsCollectionViewDelegate)?
  
  // MARK: Internal Methods
  override func cellRegister() {
    register(
      UserAlbumCell.self,
      forCellWithReuseIdentifier: UserAlbumCell.reuseID
    )
  }
  
  override func setupDelegate() {
    delegate = self
  }
}
