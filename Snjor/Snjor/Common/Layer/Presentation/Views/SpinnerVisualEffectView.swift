//
//  SpinnerVisualEffectView.swift
//  Snjor
//
//  Created by Адам on 13.07.2024.
//

import UIKit

final class SpinnerVisualEffectView: UIVisualEffectView {
  func makeSpinnerBarItem() -> UIBarButtonItem {
    let spinner = UIBarButtonItem(customView: self)
    let barButtonItem = spinner
    return barButtonItem
  }
}
