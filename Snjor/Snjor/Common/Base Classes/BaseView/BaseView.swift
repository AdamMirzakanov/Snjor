//
//  BaseView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

class BaseView: UIView {
  // MARK: Initializers
  init() {
    super.init(frame: .zero)
    initViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Internal Methods
  /// Подклассы должны переопределять этот метод.
  func initViews() { }
}
