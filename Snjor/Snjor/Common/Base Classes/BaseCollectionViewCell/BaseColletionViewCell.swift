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
    initViews()
    setupDelegate()
  }

  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Internal Methods
  /// Подклассы могут переопределять этот метод при надобности.
  func setupDelegate() { }
  
  func initViews() {
    let customView = RootView()
    contentView.addSubview(customView)
    customView.fillSuperView()
  }
}
