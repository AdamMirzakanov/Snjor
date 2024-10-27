//
//  ViewLoadable.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

// MARK: - Protocol
/// Протокол `ViewLoadable`, который определяет ассоциированный тип `RootView`,
/// представляющий собой корневое представление, наследуемое от `UIView`.
protocol ViewLoadable {
  associatedtype RootView: UIView
}

// MARK: - Protocol Extension
extension ViewLoadable where Self: UIViewController {
  /// Свойство `rootView`, обеспечивающее доступ к корневому представлению
  /// типа `RootView`, которое должно быть установлено в контроллере.
  var rootView: RootView {
    guard let customView = view as? RootView else {
      fatalError(errorMessage)
    }
    return customView
  }
  
  private var errorMessage: String {
    "Expected view to be of type \(RootView.self) but got \(type(of: view)) instead"
  }
}
