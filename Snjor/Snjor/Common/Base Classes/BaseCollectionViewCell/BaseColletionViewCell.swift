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
    initCell()
    setupDelegate()
  }

  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Internal Methods
  /// Подклассы могут переопределять этот метод при надобности.
  func setupDelegate() { }
  
  /// Подкалссы должны вызывать `super.initCell()`
  func initCell() {
    let customView = RootView()
    contentView.addSubview(customView)
    customView.fillSuperView()
  }
}
