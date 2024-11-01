//
//  PageScreenPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 01.08.2024.
//

import UIKit

final class PageScreenPhotosCollectionView: UICollectionView {
  // MARK: Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    cellRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
  
  // MARK: Private Methods
  private func cellRegister() {
    register(
      PageScreenPhotoCell.self,
      forCellWithReuseIdentifier: PageScreenPhotoCell.reuseID
    )
  }
}
