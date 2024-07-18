//
//  GlobalConst.swift
//  Snjor
//
//  Created by Адам on 15.07.2024.
//

import CoreGraphics

enum GlobalConst {
  static let half: CGFloat = 2.0
  static let smallValue = half * half          // 4
  static let defaultValue = smallValue * half  // 8
  static let middleValue = defaultValue * half // 16
  static let fullValue = middleValue * half    // 32
  static let maxValue = fullValue + smallValue // 36
  static let circle = fullValue / half         // 16
  static let defaultAlpha: CGFloat = 0.4
  static let maxAlpha: CGFloat = 1
  static let defaultFontSize: CGFloat = 14.0
}
