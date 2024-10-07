//
//  UserProfileViewControllerRootViewConst.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 10.09.2024.
//

import CoreGraphics

enum UserProfileViewControllerRootViewConst {
  static let pressingScale: CGFloat = 0.8
  static let gradientOpacity: CGFloat = 1.0
  static let gradientStartLocation: CGFloat = 1.0
  static let gradientEndLocation: CGFloat = 0.1
  static let defaultFontSize: CGFloat = 14.0
  static let indicatorPositionFontSize: CGFloat = 20.0
  static let userNameFontSize: CGFloat = 30.0
  static let avatarSize: CGFloat = 68.0
  static let avatarMulticolorBackgroundViewSize: CGFloat = 79.0
  static let checkmarkIconSize: CGFloat = 22.0
  static let checkmarkIconBackgroundViewSize: CGFloat = 13.0
  static let iconSize: CGFloat = 17.0
  static let avatarCircle: CGFloat = avatarSize / 2.0
  static let avatarMulticolorBackgroundViewCircle: CGFloat = avatarMulticolorBackgroundViewSize / 2.0
  static let middleStackViewSpacing: CGFloat = 12.0
  static let stackViewSpacing: CGFloat = 16.0
  static let defaultOpacity: CGFloat = 0.4
  static let middleOpacity: CGFloat = 0.7
  static let bigIconOpacity: CGFloat = 0.3
  static let maxOpacity: CGFloat = 1.0
  static let loacationIconSize: CGFloat = 13.0
  static let lineWidth: CGFloat = 1.0
  static let rightPadding: CGFloat = 0.0
  static let leftPadding: CGFloat = 0.0
  static let heightUserProfileCollectionView: CGFloat = 320.0
  static let infoStackViewPadding: CGFloat = 40.0
  static let userInfoStackViewHeight: CGFloat = 25.0
  static let indicatorWidthDivision: CGFloat = 3.0
  static let indicatorHeightMultiplier: CGFloat = 0.7
  static let mainCollectionViewTopPadding: CGFloat = 10.0
  static let bottomGradientViewBottomPadding: CGFloat = -100.0
  static let indicatorViewCornerRadius: CGFloat = 2.0
  static let backgroundGradientViewBottomPadding: CGFloat = 20.0
  static let userPhotosButtonLeftPadding: CGFloat = 10.0
  static let fullValue: CGFloat = 32.0
  static let defaultValue: CGFloat = 8.0
  static let smallValue: CGFloat = 4.0
  static let defaultCircle = fullValue / 2.0
  static let duration: CGFloat = 0.12
  static let bigIconSize: CGFloat = 150.0
  static let bigIconFontSize: CGFloat = 40.0
  static let stackViewCenterYOffset: CGFloat = -35
  static let bigIconFontName: String = "Impact"
}

extension Int {
  static let likedPhotos = 0
  static let userPhotos = 1
}

extension String {
  static let noLikes: String = "No likes!".uppercased()
  static let noPhotos: String = "No photos!".uppercased()
  static let noAlbums: String = "No albums!".uppercased()
}
