//
//  SpinnerVisualEffectView.swift
//  Snjor
//
//  Created by Адам on 13.07.2024.
//

import UIKit

final class SpinnerVisualEffectView: UIVisualEffectView {
  func makeSpinnerBarItem() -> UIBarButtonItem {
    let barButtonItem = UIBarButtonItem(customView: self)
    return barButtonItem
  }
}
