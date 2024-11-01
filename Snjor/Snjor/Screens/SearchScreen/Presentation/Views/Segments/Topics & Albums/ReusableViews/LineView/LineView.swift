//
//  LineView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.08.2024.
//

import UIKit

class LineView: UICollectionReusableView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .lightGray
  }
  
  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
  
  func setColor(_ color: UIColor) {
    backgroundColor = color
  }
}
