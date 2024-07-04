//
//  ViewLoadable.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

public protocol ViewLoadable {
  associatedtype MainView: UIView
}

extension ViewLoadable where Self: UIViewController {
  var mainView: MainView {
    guard let customView = view as? MainView else {
      fatalError("Expected view to be of type \(MainView.self) but got \(type(of: view)) instead")
    }
    return customView
  }
}
