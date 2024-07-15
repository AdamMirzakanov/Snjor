//
//  SpinnerDisplayable.swift
//  Snjor
//
//  Created by Адам on 24.06.2024.
//

import UIKit

protocol SpinnerDisplayable: AnyObject {
  func showSpinner(on visualEffect: UIVisualEffectView)
  func hideSpinner(from visualEffect: UIVisualEffectView)
}

extension SpinnerDisplayable where Self: UIViewController {
  // MARK: - Private Internal
  func showSpinner(on visualEffect: UIVisualEffectView) {
    guard visualEffect.viewWithTag(SpinnerConst.tagID) == nil else { return }
    configureSpinner(on: visualEffect)
  }

  func hideSpinner(from visualEffect: UIVisualEffectView) {
    if let spinner = visualEffect.viewWithTag(SpinnerConst.tagID) as? UIActivityIndicatorView {
      animateHideSpinner(spinner)
    }
  }

  // MARK: - Private Methods
  private func configureSpinner(on visualEffect: UIVisualEffectView) {
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.transform = CGAffineTransform(scaleX: .zero, y: .zero)
    spinner.startAnimating()
    spinner.color = .label
    spinner.tag = SpinnerConst.tagID
    spinner.translatesAutoresizingMaskIntoConstraints = false
    visualEffect.contentView.addSubview(spinner)
    spinner.centerXY()
    animateShowSpinner(spinner)
  }

  private func animateShowSpinner(_ spinner: UIActivityIndicatorView) {
    UIView.animate(withDuration: SpinnerConst.defaultDuration) {
      spinner.transform = CGAffineTransform(
        scaleX: SpinnerConst.defaultSpinnerScale,
        y: SpinnerConst.defaultSpinnerScale
      )
    } completion: { _ in
      UIView.animate(withDuration: SpinnerConst.halfDuration) {
        spinner.transform = CGAffineTransform(
          scaleX: SpinnerConst.spinnerScale,
          y: SpinnerConst.spinnerScale
        )
      }
    }
  }

  private func animateHideSpinner(_ spinner: UIActivityIndicatorView) {
    UIView.animate(withDuration: SpinnerConst.defaultDuration) {
      spinner.alpha = .zero
    } completion: { _ in
      spinner.removeFromSuperview()
    }
  }
}

// MARK: - Spinner Constants
private enum SpinnerConst {
  static let tagID = 123
  static let defaultDuration = 0.3
  static let halfDuration = defaultDuration / GlobalConst.half
  static let spinnerScale = 0.8
  static let defaultSpinnerScale = 1.0
}
