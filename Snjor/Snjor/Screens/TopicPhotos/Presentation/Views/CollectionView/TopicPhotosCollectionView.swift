//
//  TopicPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

final class TopicPhotosCollectionView: UICollectionView {

  // MARK: - Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    cellRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  private func cellRegister() {
    register(
      TopicPhotoCell.self,
      forCellWithReuseIdentifier: TopicPhotoCell.reuseID
    )
  }
}
