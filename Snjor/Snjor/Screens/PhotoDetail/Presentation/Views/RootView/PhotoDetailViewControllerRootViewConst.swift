//
//  PhotoDetailViewControllerRootViewConst.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

import CoreGraphics

enum PhotoDetailViewControllerRootViewConst {
  static let verticalTranslation: CGFloat = -120.0
  static let centerYOffset: CGFloat = 120.0
  static let leftStackViewCenterYOffset: CGFloat = 148.0
  static let rightStackViewCenterYOffset: CGFloat = 148.0
  static let leftStackViewCenterYOffsetNoTags: CGFloat = 137.0
  static let rightStackViewCenterYOffsetNoTags: CGFloat = 137.0
  static let tagsCollectionViewHeight: CGFloat = 22.0
  static let centerLineTopOffset: CGFloat = 179.0
  static let centerLineTopOffsetNoTags: CGFloat = 150.0
  static let downloadButtonWidth: CGFloat = 75.0
  static let resolutionLabelWidth: CGFloat = 66.0
  static let resolutionLabelHeight: CGFloat = resolutionLabelWidth / 3
  static let lineWidth: CGFloat = 1.0
  static let lineHeight: CGFloat = 100.0
  static let smallRightPadding: CGFloat = 5.0
  static let gradientStartLocation: CGFloat = 0.9
  static let gradientEndLocation: CGFloat = 0.1
  static let gradientOpacity: CGFloat = 0.8
  static let userNameFontSize: CGFloat = 22.0
  static let leftPadding: CGFloat = 20.0
  static let rightPadding: CGFloat = 20.0
  static let halfRightPadding: CGFloat = -10.0
  static let mainStackViewBottomPadding: CGFloat = 50.0
  static let infoIconSize: CGFloat = 23.0
  static let defaultDuration: CGFloat = 0.7
  static let minDuration: CGFloat = 0.2
  static let toggleButtonMinScale: CGFloat = 0.4
  static let spinnerScale: CGFloat = 0.75
  static let defaultDamping: CGFloat = 0.5
  static let defaultVelocity: CGFloat = 0.5
  static let hidePhotoInfoDuration: CGFloat = 0.3
  static let translationX: CGFloat = downloadButtonWidth - fullValue
  static let translationY: CGFloat = -10.0
  static let half: CGFloat = 2.0
  static let defaultOpacity: CGFloat = 0.4
  static let middleOpacity: CGFloat = 0.6
  static let maxOpacity: CGFloat = 1.0
  static let defaultFontSize: CGFloat = 14.0
  static let tagFontSize: CGFloat = 11.0
  static let profitStackViewSpacing: CGFloat = 20.0
  static let checkmarkIconSize: CGFloat = 19.0
  static let checkmarkIconBackgroundViewSize: CGFloat = 10.0
  static let iconSize: CGFloat = 21.0
  static let loacationIconSize: CGFloat = 13.0
  static let resolutionLabelFrameCornerRadius: CGFloat = 6.0
  static let smallValue = half * half                         // 4
  static let defaultValue = smallValue * half                 // 8
  static let middleValue = defaultValue * half                // 16
  static let fullValue = middleValue * half                   // 32
  static let maxValue = fullValue + smallValue                // 36
  static let profilePhotoSize = maxValue + middleValue        // 52
  static let defaultCircle = fullValue / half                 // 16
  static let profilePhotoCircle = profilePhotoSize / half     // 20
}

// MARK: - String
extension String {
  static let empty = String()
  static let spacer = " "
  static let defaultCamera = "iPhone 4"
  static let jpeg = " JPEG"
  static let iso = "ISO"
  static let focalLengt = "Focal"
  static let aperture = "Aperture"
  static let exposure = "Exposure"
  static let mm = " mm"
  static let 𝑓 = "𝑓 "
  static let second = " s"
  static let dash = "-"
  static let hash = "# "
  static let uhd8K = "8K UHD"
  static let uhd4K = "4K UHD"
  static let qhd2K = "2K QHD"
  static let fullHD = "Full HD"
  static let hd = "HD"
  static let impact = "Impact"
  static let timesNewRomanBold = "Times New Roman Bold"
}
