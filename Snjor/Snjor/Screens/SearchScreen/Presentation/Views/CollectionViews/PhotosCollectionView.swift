//
//  PhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

final class PhotosCollectionView: UICollectionView {
  // MARK: - Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    configureLayout()
    cellRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  private func configureLayout() {
    flowlayout.scrollDirection = .horizontal
    backgroundColor = .clear
    showsHorizontalScrollIndicator = false
  }
  
  private func cellRegister() {
    register(
      PhotosCell.self,
      forCellWithReuseIdentifier: PhotosCell.reuseID
    )
  }
}
