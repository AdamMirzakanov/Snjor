//
//  PageScreenTopicCellRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

fileprivate typealias Const = PageScreenTopicCellConst

final class PageScreenTopicCellRootView: BaseView {
  // MARK: Views
  let topicTitleLabel: UILabel = {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.font = .systemFont(
      ofSize: Const.topicTitleLabelFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  // MARK: Initializers
  override func initViews() {
    setupViews()
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubview(topicTitleLabel)
    topicTitleLabel.centerXY()
  }
}
