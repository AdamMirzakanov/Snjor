//
//  BaseViewController.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

class BaseViewController<ViewType: UIView>: UIViewController {
  typealias RootView = ViewType
  override func loadView() {
    let customView = RootView()
    view = customView
  }
}

extension BaseViewController: ViewLoadable { }
