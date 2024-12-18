//
//  PageScreenTopicCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

final class PageScreenTopicCell: BaseColletionViewCell<PageScreenTopicCellRootView> {
  // MARK: Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    rootView.topicTitleLabel.text = nil
  }
  
  // MARK: Setup Data
  func configure(viewModelItem: BaseViewModelItem<Topic>) {
    rootView.topicTitleLabel.text = viewModelItem.itemTitle
  }
}
