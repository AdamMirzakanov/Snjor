//
//  PhotoCellMainViewConst.swift
//  Snjor
//
//  Created by Адам on 14.07.2024.
//

import CoreGraphics

enum PhotoCellMainViewConst {
  static let gradientStartLocation: CGFloat = 0.7
  static let gradientEndLocation: CGFloat = 1.0
  static let gradientOpacity: CGFloat = 0.5
  static let duration: CGFloat = 0.15
  static let scale: CGFloat = 0.8
  static let half: CGFloat = 2.0
  static let smallValue = half * half            // 4
  static let defaultValue = smallValue * half    // 8
  static let middleValue = defaultValue * half   // 16
  static let fullValue = middleValue * half      // 32
  static let defaultOpacity: CGFloat = 0.4
  static let maxOpacity: CGFloat = 1.0
  static let userNameLabelFontSize: CGFloat = 14.0
  static let spinnerScale: CGFloat = 0.75
}
