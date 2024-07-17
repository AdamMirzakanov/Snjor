//
//  SpinnerDisplayable.swift
//  Snjor
//
//  Created by Адам on 24.06.2024.
//

import UIKit

protocol SpinnerDisplayable {
//  func showSpinner(on activityIndicator: UIActivityIndicatorView)
//  func hideSpinner(from activityIndicator: UIActivityIndicatorView)
}

extension SpinnerDisplayable where Self: UIViewController {
  // MARK: - Private Internal
//  func showSpinner(on activityIndicator: UIActivityIndicatorView) {
//    guard activityIndicator.viewWithTag(SpinnerConst.tagID) == nil else { return }
//    configureSpinner(on: activityIndicator)
//  }

//  func hideSpinner(from activityIndicator: UIActivityIndicatorView) {
//    if let spinner = activityIndicator.viewWithTag(SpinnerConst.tagID) as? UIActivityIndicatorView {
//      animateHideSpinner(spinner)
//    }
//  }

  // MARK: - Private Methods
//  private func configureSpinner(on activityIndicator: UIActivityIndicatorView) {
//    let spinner = UIActivityIndicatorView(style: .medium)
//    spinner.transform = CGAffineTransform(scaleX: .zero, y: .zero)
//    spinner.startAnimating()
//    spinner.color = .label
//    spinner.tag = SpinnerConst.tagID
//    spinner.translatesAutoresizingMaskIntoConstraints = false
//    activityIndicator.contentView.addSubview(spinner)
//    spinner.fillSuperView()
//    animateShowSpinner(spinner)
//  }

  private func animateShowSpinner(_ activityIndicator: UIActivityIndicatorView) {
    UIView.animate(withDuration: SpinnerConst.defaultDuration) {
      activityIndicator.transform = CGAffineTransform(
        scaleX: SpinnerConst.defaultSpinnerScale,
        y: SpinnerConst.defaultSpinnerScale
      )
    } completion: { _ in
      UIView.animate(withDuration: SpinnerConst.halfDuration) {
        activityIndicator.transform = CGAffineTransform(
          scaleX: SpinnerConst.spinnerScale,
          y: SpinnerConst.spinnerScale
        )
      }
    }
  }

  private func animateHideSpinner(_ activityIndicator: UIActivityIndicatorView) {
    UIView.animate(withDuration: SpinnerConst.defaultDuration) {
      activityIndicator.alpha = .zero
    } completion: { _ in
      activityIndicator.removeFromSuperview()
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
