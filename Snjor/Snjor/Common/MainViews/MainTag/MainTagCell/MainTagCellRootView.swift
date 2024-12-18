//
//  MainTagCellRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

fileprivate typealias Const = MainTagCellConst

final class MainTagCellRootView: BaseView {
  // MARK: Views
  var tagLabel: UILabel = {
    $0.textAlignment = .center
    $0.layer.cornerRadius = Const.tagLabelCornerRadius
    $0.layer.masksToBounds = true
    $0.font = .systemFont(
      ofSize: Const.tagFontSize,
      weight: .regular
    )
    return $0
  }(UILabel())
  
  // MARK: Setup Views
  override func initViews() {
    addSubview(tagLabel)
    tagLabel.fillSuperView()
  }
}
