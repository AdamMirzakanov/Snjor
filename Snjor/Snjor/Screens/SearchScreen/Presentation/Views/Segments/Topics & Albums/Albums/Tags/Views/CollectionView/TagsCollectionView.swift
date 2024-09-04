//
//  TagsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

import UIKit

final class TagsCollectionView: UICollectionView {
  
  // MARK: Internal Properties
  var tags: [Tag] = []
  
  // MARK: Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    delegate = self
    dataSource = self
    configureLayout()
    cellRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Private Methods
  private func configureLayout() {
    flowlayout.scrollDirection = .horizontal
    backgroundColor = .clear
    showsHorizontalScrollIndicator = false
  }
  
  private func cellRegister() {
    register(
      TagCell.self,
      forCellWithReuseIdentifier: TagCell.reuseID
    )
  }
}
