//
//  MessageDisplayable.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol MessageDisplayable { }

extension MessageDisplayable where Self: UIViewController {
  func presentAlert(message: String, title: String) {
    let alertController = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)

    let okAction = UIAlertAction(title: .ok, style: .cancel)
    alertController.addAction(okAction)
    self.present(alertController, animated: true)
  }
}

private extension String {
  static let ok = "Ok"
}
