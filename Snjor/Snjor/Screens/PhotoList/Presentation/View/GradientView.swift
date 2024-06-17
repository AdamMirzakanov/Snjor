//
//  GradientView.swift
//  Snjor
//
//  Created by Адам on 17.06.2024.
//

import UIKit

class GradientView: UIView {
  // MARK: - Public Struct
  struct Color {
    let color: UIColor
    let location: CGFloat
  }

  // MARK: - Private Properties
  private var colors: [Color] = []

  // MARK: - Public Methods
  func setColors(_ colors: [Color]) {
    self.colors = colors
    updateGradient()
  }

  // MARK: - Override Methods
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }

  // MARK: - Private Methods
  private func updateGradient() {
    guard let gradientLayer = layer as? CAGradientLayer else { return }
    gradientLayer.colors = colors.map { $0.color.cgColor }
    gradientLayer.locations = colors.map { $0.location } as [NSNumber]
  }
}
