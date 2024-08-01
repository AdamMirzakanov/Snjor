//
//  CascadeLayoutConst.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

enum CascadeLayoutConst {
  static var headerHeight: CGFloat = 0.0
  static let topInset: CGFloat = headerHeight + getAdjustedSpacing()
  static let singleColumns = 1
  static let iPhoneColumns = 2
  static let iPadColumns = 3
  static let columnSpacing = getAdjustedSpacing()
  static let singleColumnSpacing: CGFloat = 60.0
  
  static func getAdjustedSpacing() -> CGFloat {
    let screenWidth = Int(UIScreen.main.bounds.width)
    return screenWidth % 2 == 0 ? 2 : 3
  }
}
