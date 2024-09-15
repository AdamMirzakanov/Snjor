//
//  FirstCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

/// Первая из трех ячеек горизонтальной коллекции
final class FirstCell: UICollectionViewCell {
  // MARK: Internal Properties
  var likedPhotos: [Photo] = []
  
  // MARK: Views
  let userLikedPhotosCollectionView: UserLikedPhotosCollectionView = {
    return $0
  }(UserLikedPhotosCollectionView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupDelegate()
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Internal Methods
  func configure(with photos: [Photo]) {
    self.likedPhotos = photos
    userLikedPhotosCollectionView.reloadData()
  }
  
  // MARK: Private Methods
  private func setupDelegate() {
    userLikedPhotosCollectionView.delegate = self
    userLikedPhotosCollectionView.dataSource = self
  }
  
  private func setupViews() {
    contentView.addSubview(userLikedPhotosCollectionView)
    userLikedPhotosCollectionView.frame = contentView.bounds
  }
}

