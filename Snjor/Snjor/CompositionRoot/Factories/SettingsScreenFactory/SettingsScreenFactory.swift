//
//  SettingsScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.10.2024.
//

import UIKit

fileprivate typealias Const = SettinsScreenFactoryConst

struct SettingsScreenFactory: SettingsScreenFactoryProtocol {
  // MARK: Internal Methods
  func makeController() -> UIViewController {
    let controller = SettingsViewController()
    controller.navigationItem.title = Const.settingsTitle
    return controller
  }
}
