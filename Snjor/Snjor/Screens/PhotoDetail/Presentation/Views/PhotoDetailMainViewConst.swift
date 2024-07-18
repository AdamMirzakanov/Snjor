//
//  PhotoDetailMainViewConst.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import CoreGraphics

enum PhotoDetailMainViewConst {

  //left stack & right stack & center line
  static let verticalTranslation: CGFloat = -120.0
  static let centerYOffset: CGFloat = 120.0
  static let topOffset: CGFloat = 125.0
  static let downloadButtonWidth: CGFloat = 72.0
  static let resolutionLabelWidth: CGFloat = 66.0
  static let resolutionLabelHeight: CGFloat = resolutionLabelWidth / 3
  static let lineWidth: CGFloat = 1.0
  static let lineHeight: CGFloat = 100.0

  //gradient
  static let upLocation: CGFloat = 0.9
  static let downLocation: CGFloat = 0.1
  static let gradientAlpha: CGFloat = 0.8

  //fonts
  static let userNameFontSize: CGFloat = 20.0

  //constraints
  static let leftPadding: CGFloat = 20.0
  static let rightPadding: CGFloat = 20.0
  static let halfRightPadding: CGFloat = -10.0
  static let bottomPadding: CGFloat = 50.0
  static let infoIconSize: CGFloat = 23.0

  //animate
  static let defaultDuration: CGFloat = 0.7
  static let minDuration: CGFloat = 0.2
  static let toggleButtonMinScale: CGFloat = 0.2
  static let spinnerScale: CGFloat = 0.75
  static let damping: CGFloat = 0.5
  static let velocity: CGFloat = 0.5
  static let hidePhotoInfoDuration: CGFloat = 0.3
  static let translationX: CGFloat = downloadButtonWidth - GlobalConst.fullValue
  static let translationY: CGFloat = -10.0
}
