//
//  TopicCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

final class TopicCell: BaseColletionViewCell<TopicCellRootView> {
  // MARK: Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    rootView.mainView.prepareForReuse()
  }
  
  // MARK: Setup Data
  func configure(viewModelItem: BaseViewModelItem<Topic>) {
    let topic = viewModelItem.item
    let coverPhotoURL = viewModelItem.photoURL
    rootView.mainView.configure(with: topic, url: coverPhotoURL)
  }
}
