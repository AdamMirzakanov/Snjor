//
//  Navigation + UIAdaptivePresentationControllerDelegate.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

extension Navigation: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidDismiss(
    _ presentationController: UIPresentationController
  ) {
    dismissNavigation?()
    dismissNavigation = nil
  }
}
