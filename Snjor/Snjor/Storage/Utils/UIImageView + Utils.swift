//
//  UIImageView + Utils.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import UIKit

extension UIImageView {
  func setImageFromData(data: Data?) {
    if let data = data {
      if let image = UIImage(data: data) {
        UIView.transition(
          with: self,
          duration: 0.25,
          options: [.transitionCrossDissolve]) {
            self.image = image
        }
      }
    }
  }
}
