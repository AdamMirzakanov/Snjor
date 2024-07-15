//
//  BaseViewController.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

class BaseViewController<ViewType: UIView>: UIViewController {
  typealias MainView = ViewType
  override func loadView() {
    let customView = MainView()
    view = customView
  }
}

extension BaseViewController: ViewLoadable { }
