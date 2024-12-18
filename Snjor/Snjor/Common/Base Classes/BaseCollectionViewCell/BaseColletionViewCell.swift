//
//  BaseColletionViewCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

class BaseColletionViewCell<ViewType: UIView>: UICollectionViewCell {
  typealias RootView = ViewType

  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Private Methods
  private func setupViews() {
    let customView = RootView()
    contentView.addSubview(customView)
    customView.fillSuperView()
  }
}
