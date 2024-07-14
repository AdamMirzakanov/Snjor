//
//  ViewController.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

class ViewController<ViewType: UIView>: UIViewController, ViewLoadable {
  typealias MainView = ViewType
  override func loadView() {
    let customView = MainView()
    view = customView
  }
}
