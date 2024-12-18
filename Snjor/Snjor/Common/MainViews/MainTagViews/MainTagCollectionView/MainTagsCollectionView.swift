//
//  MainTagsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

import UIKit

class MainTagsCollectionView: BaseCollectionView {
  // MARK: Internal Properties
  var tags: [Tag] = []
  
  // MARK: Private Methods
  override func configureLayout() {
    flowlayout.scrollDirection = .horizontal
    backgroundColor = .clear
    showsHorizontalScrollIndicator = false
  }
}
