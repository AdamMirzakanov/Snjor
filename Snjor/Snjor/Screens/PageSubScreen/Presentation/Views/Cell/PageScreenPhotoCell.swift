//
//  PageScreenPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 30.07.2024.
//

import UIKit

final class PageScreenPhotoCell: BaseColletionViewCell<PageScreenPhotoCellRootView> {
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
