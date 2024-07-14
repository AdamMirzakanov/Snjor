//
//  PhotoDetailConst.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import CoreGraphics

enum PhotoDetailConst {
  static let half: CGFloat = 2.0
  static let smallValue: CGFloat = half * half          // 4
  static let defaultValue: CGFloat = smallValue * half  // 8
  static let middleValue: CGFloat = defaultValue * half // 16
  static let fullValue: CGFloat = middleValue * half    // 32
  static let maxValue: CGFloat = fullValue + smallValue // 36
  static let circle: CGFloat = fullValue / half         // 16
  static let defaultAlpha: CGFloat = 0.4
  static let maxAlpha: CGFloat = 1

  //left & right stack views & center line
  static let verticalTranslation: CGFloat = -120.0
  static let centerYOffset: CGFloat = 120.0
  static let topOffset: CGFloat = 125.0
  static let downloadButtonWidth: CGFloat = 72.0
  static let resolutionLabelWidth: CGFloat = 66
  static let resolutionLabelHeight: CGFloat = resolutionLabelWidth / 3 // 22
  static let lineWidth: CGFloat = 1.0
  static let lineHeight: CGFloat = 100.0

  //gradient
  static let upLocation: CGFloat = 0.9
  static let downLocation: CGFloat = 0.1
  static let gradientAlpha: CGFloat = 0.8

  //fonts
  static let defaultFontSize: CGFloat = 13.0
  static let userNameFontSize: CGFloat = 20.0

  //constraints
  static let leftPadding: CGFloat = 20.0
  static let rightPadding: CGFloat = 20.0
  static let halfRightPadding: CGFloat = -10.0
  static let bottomPadding: CGFloat = 50

  //animate
  static let duration: CGFloat = 0.7
  static let damping: CGFloat = 0.5
  static let velocity: CGFloat = 0.5
  static let hidePhotoInfoDuration: CGFloat = 0.3
  static let translationX: CGFloat = downloadButtonWidth - fullValue
  static let translationY: CGFloat = -10
}

extension String {
  static var empty: String { String() }
  static var defaultCamera: String { "iPhone 4" }
  static var defaultUserName: String { "Adam Mirzakanov" }
  static var defaultProfilePhoto: String { "profile" }
  static var defaultDate: String { "6 Aug 1992 at 10:00" }

  static var jpeg: String { " JPEG" }
  static var iso: String { "ISO" }
  static var focalLengt: String { "Focal" }
  static var aperture: String { "Aperture" }
  static var exposure: String { "Exposure" }

  static var mm: String { " mm" }
  static var 𝑓: String { "𝑓 " }
  static var second: String { " s" }
  static var dash: String { "-" }

  //resolution
  static var uhd8K: String { "8K UHD" }
  static var uhd4K : String { "4K UHD" }
  static var qhd2K : String { "2K QHD" }
  static var fullHD: String { "Full HD" }
  static var hd: String { "HD" }
  static var sd: String { "SD" }

  //sf symbols
  static var backBarButtonImage: String { "chevron.backward" }
  static var downloadBarButtonImage: String { "arrow.down.app.fill" }
  static var stopBarButtonImage: String { "stop.circle" }
  static var pauseBarButtonImage: String { "pause.fill" }
  static var resumeBarButtonImage: String { "play.fill" }
  static var infoButtonImage: String { "info.circle" }
  static var cameraImage: String { "camera.aperture" }
  static var heartImage: String { "heart.fill" }
  static var downloadsImage: String { "tray.and.arrow.down.fill" }
  static var arrowDown: String { "arrow.down.forward.and.arrow.up.backward" }
  static var arrowUp: String { "arrow.up.backward.and.arrow.down.forward" }

  //font
  static var nameFont: String { "Times New Roman Bold" }

  //download
  static var jpegExtension: String { "jpg" }
  static var downloadsSessionID: String { "com.snjor" }
}
