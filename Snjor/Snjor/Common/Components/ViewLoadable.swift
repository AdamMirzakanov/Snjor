//
//  ViewLoadable.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

// MARK: - Protocol
protocol ViewLoadable {
  associatedtype RootView: UIView
}

// MARK: - Protocol Extension
extension ViewLoadable where Self: UIViewController {
  var rootView: RootView {
    guard let customView = view as? RootView else {
      fatalError(
        "Expected view to be of type \(RootView.self) but got \(type(of: view)) instead"
      )
    }
    return customView
  }
}
