//
//  UserProfileViewControllerRootViewConst.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 10.09.2024.
//

import CoreGraphics

enum UserProfileViewControllerRootViewConst {
  static let gradientOpacity: CGFloat = 1.0
  static let gradientStartLocation: CGFloat = 0.8
  static let gradientEndLocation: CGFloat = 0.01
  static let defaultFontSize: CGFloat = 14.0
  static let indicatorPositionFontSize: CGFloat = 20.0
  static let userNameFontSize: CGFloat = 30.0
  static let profilePhotoSize: CGFloat = 70.0
  static let iconsStackViewHeight: CGFloat = 17.0
  static let iconSize: CGFloat = 17.0
  static let profilePhotoCircle: CGFloat = profilePhotoSize / 2
  static let halfStackViewSpacing: CGFloat = stackViewSpacing / 2
  static let stackViewSpacing: CGFloat = 16.0
  static let defaultOpacity: CGFloat = 0.4
  static let maxOpacity: CGFloat = 1.0
  static let lineWidth: CGFloat = 1.0
  static let rightPadding: CGFloat = 0.0
  static let leftPadding: CGFloat = 0.0
  static let heightUserProfileCollectionView: CGFloat = 300.0
  static let infoStackViewPadding: CGFloat = 40.0
  static let indicatorWidthDivision: CGFloat = 3.0
  static let indicatorHeightMultiplier: CGFloat = 0.7
  static let mainCollectionViewTopPadding: CGFloat = 10
  static let bottomGradientViewBottomPadding: CGFloat = -100
  static let indicatorViewCornerRadius: CGFloat = 2.0
}

extension Int {
  static let likedPhotos = 0
  static let userHasPhotos = 1
}

extension String {
  static let liked = "Liked "
  static let userHas = "User has "
  static let photos = " photos"
  static let albums = " albums "
}
