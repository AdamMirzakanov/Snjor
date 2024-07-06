//
//  String + Extension.swift
//  Snjor
//
//  Created by Адам on 27.06.2024.
//

extension String {

  // Default value
  static var empty: String { String() }
  static var likesDefault: String { "0" }
  static var downloadDefault: String { "0" }
  static var viewsDefault: String { "0" }
  static var cameraDefault: String { "iPhone X" }
  static var resolutionDefault: String { qhd2K }
  static var pxlDefault: String { "0000 × 0000" }
  static var isoDefault: String { iso + "000" + dot}
  static var focalLengtDefault: String { "0" }
  static var apertureDefault: String { "0.0" }
  static var exposureDefault: String { "0/0" }
  static var instagramUsernameDefault: String { "oracle____" }
  static var twitterUsernameDefault: String { "oracle____" }
  static var nameDefault: String { "Adam Mirzakanov" }
  static var snjor: String { "S  N  J  Ø  R" }

  static var jpeg: String { " JPEG" }
  static var dot: String { " • " }
  static var iso: String { "ISO " }
  static var millimeter: String { " mm" }
  static var aperture: String { "𝑓 " }
  static var exposure: String { " s" }

  // Resolution
  static var uhd8K: String { "8K UHD" }
  static var uhd4K : String { "4K UHD" }
  static var qhd2K : String { "2K QHD" }
  static var fullHD: String { "Full HD" }
  static var hd: String { "HD" }
  static var standard: String { "Standard Definition" }

  // MARK: - Images
  static var backBarButtonImage: String { "chevron.backward" }
  static var downloadBarButtonImage: String { "arrow.down.app.fill" }
  static var stopBarButtonImage: String { "stop.circle" }
  static var pauseBarButtonImage: String { "pause.fill" }
  static var resumeBarButtonImage: String { "play.fill" }
  static var infoButtonImage: String { "info.circle" }

  // Toggle content mode button
  static var arrowDown: String { "arrow.down.forward.and.arrow.up.backward" }
  static var arrowUp: String { "arrow.up.backward.and.arrow.down.forward" }

  // Profitability
  static var heartImage: String { "heart.fill" }
  static var downloadsImage: String { "tray.and.arrow.down.fill" }
  static var viewsImage: String { "sparkles" }

  static var cameraImage: String { "camera.aperture" }

  // Profile default photo
  static var profileDefaultPhotoImage: String { "profile" }

  // MARK: - Fonts
  static var nameFont: String { "Times New Roman Bold" }

  // MARK: - Downloads
  static var jpegExtension: String { "jpg" }
  static var downloadsSessionID: String { "com.adamirzakan" }
}
