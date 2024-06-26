//
//  PhotoConstants.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import CoreGraphics

enum PhotoConstants {
  static let alpha: CGFloat = 0.5
  static let profilePhotoSize: CGFloat = 54.0
  static let logoSize: CGFloat = 17.0

  static let profilePhotoCornerRadius: CGFloat = profilePhotoSize / half
  static let resolutionLabelCornerRadius: CGFloat = smallValue

  static let half: CGFloat = 2.0
  static let smallValue: CGFloat = half * half
  static let defaultValue: CGFloat = smallValue * half
  static let midlValue: CGFloat = defaultValue * half
  static let longValue: CGFloat = midlValue * half

  static let defaultFontSize: CGFloat = 15.0
  static let nameFontSize: CGFloat = 25.0

  // constraints value
  static let photoViewBottomAnchor: CGFloat = -150.0
  static let mainStackLeadingAnchor: CGFloat = 16.0
  static let mainStackViewBottomAnchor: CGFloat = 0.0
  static let lineHeightAnchor: CGFloat = 1.0
  static let resolutionLabelWidth: CGFloat = 66
  static let resolutionLabelHeight: CGFloat = resolutionLabelWidth / 3
  static let downloadButtonWidth: CGFloat = 74.0
  static let downloadButtonHeight: CGFloat = 32.0
}

enum DefaultTextForLabel {
  static let dot = " • "
  static let instagramUsername = "oracle_____"
  static let twitterUsername = "oracle_____"
  static let cameraModel = "iPhone 15 Pro"
}

enum Resolution {
  static let uhd8K = "8K UHD"
  static let uhd4K = "4K UHD"
  static let qhd2K = "2K QHD"
  static let fullHD = "Full HD"
  static let hd = "HD"
  static let standard = "Standard Definition"
}
