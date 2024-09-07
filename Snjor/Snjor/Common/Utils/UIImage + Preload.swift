//
//  UIImage + Preload.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import UIKit

extension UIImage {
  func preloadedImage() -> UIImage {
    guard let imageRef = self.cgImage else {
      return self
    }

    let width = imageRef.width
    let height = imageRef.height
    let colourSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo: UInt32 = CGImageAlphaInfo
      .noneSkipLast
      .rawValue | CGBitmapInfo
      .byteOrder32Little
      .rawValue

    guard
      let imageContext = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: PreloadedConst.bitsPerComponent,
        bytesPerRow: width * PreloadedConst.bytesPerRow,
        space: colourSpace,
        bitmapInfo: bitmapInfo
      )
    else {
      return self // failed
    }

    let rect = CGRect(
      x: .zero,
      y: .zero,
      width: width,
      height: height
    )

    imageContext.draw(imageRef, in: rect)

    if let outputImage = imageContext.makeImage() {
      let cachedImage = UIImage(
        cgImage: outputImage,
        scale: scale,
        orientation: imageOrientation
      )
      return cachedImage
    }
    return self
  }
}

// MARK: - Constants
private enum PreloadedConst {
  static let bitsPerComponent = 8
  static let bytesPerRow = 4
}
