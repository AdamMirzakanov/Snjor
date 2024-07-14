//
//  SpinnerVisualEffectView.swift
//  Snjor
//
//  Created by Адам on 13.07.2024.
//

import UIKit

class SpinnerVisualEffectView: UIVisualEffectView {
  func setupBarItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    navigationItem.rightBarButtonItem = makeSpinnerBarItem()
  }

  func makeSpinnerBarItem() -> UIBarButtonItem {
    let spinner = UIBarButtonItem(customView: self)
    let barButtonItem = spinner
    return barButtonItem
  }
}
