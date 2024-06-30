//
//  UIConst.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import CoreGraphics

enum UIConst {

  // MARK: - PhotoDetailViewController
  static let alpha: CGFloat = 0.5
  static let profilePhotoSize: CGFloat = 52.0
  static let blurViewSize: CGFloat = 36.0
  static let logoSize: CGFloat = 17.0

  static let profilePhotoCornerRadius: CGFloat = profilePhotoSize / half
  static let backButtonBlurViewCornerRadius: CGFloat = downloadButtonHeight / half
  static let resolutionLabelCornerRadius: CGFloat = smallValue

  static let half: CGFloat = 2.0
  static let smallValue: CGFloat = half * half
  static let defaultValue: CGFloat = smallValue * half
  static let midlValue: CGFloat = defaultValue * half
  static let longValue: CGFloat = midlValue * half

  // Photo detail gradient
  static let location: CGFloat = 0.7
  static let halfLocation: CGFloat = location / half
  static let gradientAlpha: CGFloat = 1.0

  static let defaultFontSize: CGFloat = 15.0
  static let nameFontSize: CGFloat = 20.0

  // Constraints value
  static let photoViewBottomAnchor: CGFloat = -200.0
  static let mainStackLeadingAnchor: CGFloat = 16.0
  static let mainStackViewBottomAnchor: CGFloat = -50.0
  static let lineHeightAnchor: CGFloat = 1.0
  static let resolutionLabelWidth: CGFloat = 66
  static let resolutionLabelHeight: CGFloat = resolutionLabelWidth / 3
  static let downloadButtonWidth: CGFloat = 74.0
  static let downloadButtonHeight: CGFloat = 32.0

  // MARK: -
}
