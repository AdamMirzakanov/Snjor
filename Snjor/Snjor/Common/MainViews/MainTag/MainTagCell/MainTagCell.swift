//
//  MainTagCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

import UIKit

fileprivate typealias Const = MainTagCellConst

class MainTagCell: BaseColletionViewCell<MainTagCellRootView> {
  // MARK: Cell Config
  func configure(with tag: Tag) {
    rootView.tagLabel.text = .hash + tag.title
  }
}
