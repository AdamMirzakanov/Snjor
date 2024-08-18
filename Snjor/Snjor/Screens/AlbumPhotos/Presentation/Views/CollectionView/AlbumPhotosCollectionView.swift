//
//  AlbumPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

final class AlbumPhotosCollectionView: UICollectionView {

  // MARK: - Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    cellRegister()
    showsVerticalScrollIndicator = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  private func cellRegister() {
    register(
      AlbumPhotoCell.self,
      forCellWithReuseIdentifier: AlbumPhotoCell.reuseID
    )
  }
}
