//
//  CascadeLayoutConst.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

enum CascadeLayoutConst {
  static let columnSpacing = getAdjustedSpacing()
  static var iPhoneColumns = 2
  static let iPadColumns = 3

  static func getAdjustedSpacing() -> CGFloat {
    let screenWidth = Int(UIScreen.main.bounds.width)
    return screenWidth % 2 == 0 ? 2 : 3
  }
}
