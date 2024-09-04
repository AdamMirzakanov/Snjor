//
//  MainViewController.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

class MainViewController<ViewType: UIView>: UIViewController {
  typealias RootView = ViewType
  override func loadView() {
    let customView = RootView()
    view = customView
  }
}
