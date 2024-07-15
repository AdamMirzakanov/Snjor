//
//  UIColor + DecodeHex.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import UIKit

extension UIColor {
  // MARK: - Private Properties
  private var redComponent: CGFloat { return cgColor.components?[0] ?? 0 }
  private var greenComponent: CGFloat { return cgColor.components?[1] ?? 0 }
  private var blueComponent: CGFloat { return cgColor.components?[2] ?? 0 }

  private var alpha: CGFloat {
    guard let components = cgColor.components else { return 1 }
    return components[cgColor.numberOfComponents - 1]
  }

  private var hexString: String {
    return NSString(
      format: "%02X%02X%02X%02X",
      Int(round(redComponent * 255)),
      Int(round(greenComponent * 255)),
      Int(round(blueComponent * 255)),
      Int(round(alpha * 255))
    ) as String
  }

  // MARK: - Initializers
  convenience init(
    hexString: String
  ) {
    var chars = Array(hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 1

    switch chars.count {
    case 3:
      chars = [
        chars[0],
        chars[0],
        chars[1],
        chars[1],
        chars[2],
        chars[2]
      ]
      fallthrough
    case 6:
      chars = ["F", "F"] + chars
      fallthrough
    case 8:
      alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
      red = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
      green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
      blue = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
    default:
      alpha = 0
    }

    self.init(
      red: red,
      green: green,
      blue: blue,
      alpha: alpha
    )
  }
}
