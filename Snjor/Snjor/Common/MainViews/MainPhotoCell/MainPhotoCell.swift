//
//  MainPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 31.08.2024.
//

import UIKit

class MainPhotoCell: BaseColletionViewCell<MainPhotoCellRootView> {
  // MARK: Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    rootView.mainView.prepareForReuse()
  }

  // MARK: Setup Data
  func configure(viewModelItem: BaseViewModelItem<Photo>) {
    let photo = viewModelItem.item
    let photoURL = viewModelItem.photoURL
    rootView.mainView.configure(with: photo, url: photoURL)
  }
}
