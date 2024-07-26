//
//  UIView + Constraints.swift
//  Snjor
//
//  Created by Адам on 24.06.2024.
//

import UIKit

extension UIView {
  func setConstraints(
    top: NSLayoutYAxisAnchor? = nil,
    right: NSLayoutXAxisAnchor? = nil,
    bottom: NSLayoutYAxisAnchor? = nil,
    left: NSLayoutXAxisAnchor? = nil,
    centerY: NSLayoutYAxisAnchor? = nil,
    centerX: NSLayoutXAxisAnchor? = nil,
    pTop: CGFloat = CGFloat.zero,
    pRight: CGFloat = CGFloat.zero,
    pBottom: CGFloat = CGFloat.zero,
    pLeft: CGFloat = CGFloat.zero,
    pCenterY: CGFloat = CGFloat.zero,
    pCenterX: CGFloat = CGFloat.zero
  ) {

    translatesAutoresizingMaskIntoConstraints = false

    if let top = top {
      topAnchor.constraint(
        equalTo: top,
        constant: pTop
      ).isActive = true
    }

    if let right = right {
      rightAnchor.constraint(
        equalTo: right,
        constant: -pRight
      ).isActive = true
    }

    if let bottom = bottom {
      bottomAnchor.constraint(
        equalTo: bottom,
        constant: -pBottom
      ).isActive = true
    }

    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: pLeft).isActive = true
    }
    
    if let centerY = centerY {
      centerYAnchor.constraint(
        equalTo: centerY,
        constant: pCenterY
      ).isActive = true
    }

    if let centerX = centerX {
      centerXAnchor.constraint(
        equalTo: centerX,
        constant: pCenterX
      ).isActive = true
    }
  }

  func fillSuperView(widthPadding: CGFloat = .zero) {
    guard let superview = self.superview else { return }
    setConstraints(
      top: superview.topAnchor,
      right: superview.rightAnchor,
      bottom: superview.bottomAnchor,
      left: superview.leftAnchor,
      pTop: widthPadding,
      pRight: widthPadding,
      pBottom: widthPadding,
      pLeft: widthPadding)
  }

  func centerY() {
    guard let superview = self.superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
  }

  func centerX() {
    guard let superview = self.superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
  }

  func centerXY() {
    centerY()
    centerX()
  }
}
