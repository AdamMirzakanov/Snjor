//
//  SettingsScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.10.2024.
//

import UIKit

struct SettingsScreenFactory: SettingsScreenFactoryProtocol {
  // MARK: Internal Methods
  func makeController() -> UIViewController {
    return SettingsViewController()
  }
}
