//
//  String + Extension.swift
//  Snjor
//
//  Created by Адам on 27.06.2024.
//

extension String {

  // Default
  static var empty: String { String() }
  static var cameraDefault: String { "iPhone 15 Pro" }
  static var focalLengtDefault: String { "0" }
  static var apertureDefault: String { "0.0" }
  static var exposureDefault: String { "0/0" }
  static var instagramUsernameDefault: String { "oracle____" }
  static var twitterUsernameDefault: String { "oracle____" }

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
}
