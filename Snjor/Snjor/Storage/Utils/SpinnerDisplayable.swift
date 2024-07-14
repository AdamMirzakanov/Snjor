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
  func showSpinner(on visualEffect: UIVisualEffectView) {
    guard visualEffect.viewWithTag(ViewValues.tagIdentifierSpinner) == nil else { return }
    configureSpinner(on: visualEffect)
  }

  func hideSpinner(from visualEffect: UIVisualEffectView) {
    if let spinner = visualEffect.viewWithTag(ViewValues.tagIdentifierSpinner) as? UIActivityIndicatorView {
      animateHideSpinner(spinner)
    }
  }

  private func configureSpinner(on visualEffect: UIVisualEffectView) {
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.transform = CGAffineTransform(scaleX: .zero, y: .zero)
    spinner.startAnimating()
    spinner.color = .label
    spinner.tag = ViewValues.tagIdentifierSpinner
    spinner.translatesAutoresizingMaskIntoConstraints = false
    visualEffect.contentView.addSubview(spinner)
    spinner.centerXY()
    animateShowSpinner(spinner)
  }

  private func animateShowSpinner(_ spinner: UIActivityIndicatorView) {
    UIView.animate(withDuration: 0.3) {
      spinner.transform = CGAffineTransform(scaleX: 1, y: 1)
    } completion: { _ in
      UIView.animate(withDuration: 0.15) {
        spinner.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      }
    }
  }

  private func animateHideSpinner(_ spinner: UIActivityIndicatorView) {
    UIView.animate(withDuration: 0.3) {
      spinner.alpha = 0
    } completion: { _ in
      spinner.removeFromSuperview()
    }
  }
}
