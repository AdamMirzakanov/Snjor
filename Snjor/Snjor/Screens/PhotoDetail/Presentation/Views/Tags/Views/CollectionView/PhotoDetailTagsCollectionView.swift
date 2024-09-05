//
//  PhotoDetailTagsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

final class PhotoDetailTagsCollectionView: MainTagsCollectionView {
  
  // MARK: Internal Properties
  weak var tagsDelegate: (any PhotoDetailTagsCollectionViewDelegate)?
  
  // MARK: Internal Methods
  override func setupDelegate() {
    delegate = self
    dataSource = self
  }
  
  override func cellRegister() {
    register(
      PhotoDetailTagCell.self,
      forCellWithReuseIdentifier: PhotoDetailTagCell.reuseID
    )
  }
  
  override func configureLayout() {
    super.configureLayout()
    bounces = false
  }
}
