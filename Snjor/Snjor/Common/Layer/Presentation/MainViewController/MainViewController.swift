//
//  MainViewController.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

class MainViewController<ViewType: UIView>: UIViewController {
  
  typealias RootView = ViewType
  
  // MARK: Override Properties
  override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
    return .bottom
  }
  
  // MARK: Override Methods
  override func loadView() {
    let customView = RootView()
    view = customView
  }
}
