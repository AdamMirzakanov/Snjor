//
//  SpinnerDisplayable.swift
//  Snjor
//
//  Created by Адам on 24.06.2024.
//

import UIKit

//protocol SpinnerDisplayable: AnyObject {
//  func showSpinner()
//  func hideSpinner()
//}
//
//extension SpinnerDisplayable where Self: UIViewController {
//  func showSpinner() {
//    guard doesNotExistAnotherSpinner else { return }
//    configureSpinner()
//  }
//
//  private func configureSpinner() {
//    let containerView = UIView()
//    containerView.tag = ViewValues.tagIdentifierSpinner
//    parentView.addSubview(containerView)
//    containerView.fillSuperView()
//    containerView.backgroundColor = .systemBackground
//    addSpinnerIndicatorToContainer(containerView: containerView)
//  }
//
//  private func addSpinnerIndicatorToContainer(containerView: UIView) {
//    let spinner = UIActivityIndicatorView(style: .medium)
//    spinner.startAnimating()
//    spinner.color = .systemGray
//    containerView.addSubview(spinner)
//    spinner.centerXY()
//  }
//
//  func hideSpinner() {
//    if let foundView = parentView.viewWithTag(ViewValues.tagIdentifierSpinner) {
//      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//        UIView.animate(
//          withDuration: 0.2,
//          animations: { foundView.alpha = 0
//          }, completion: { _ in
//            foundView.removeFromSuperview()
//          }
//        )
//      }
//    }
//  }
//
//  private var doesNotExistAnotherSpinner: Bool {
//    parentView.viewWithTag(ViewValues.tagIdentifierSpinner) == nil
//  }
//
//  private var parentView: UIView {
//    navigationController?.topViewController?.view ?? view
//  }
//}


protocol SpinnerDisplayable: AnyObject {
  func showSpinner(on button: UIVisualEffectView)
  func hideSpinner(from button: UIVisualEffectView)
}

extension SpinnerDisplayable where Self: UIViewController {
  func showSpinner(on button: UIVisualEffectView) {
    guard button.viewWithTag(ViewValues.tagIdentifierSpinner) == nil else { return }
    configureSpinner(on: button)
  }

  private func configureSpinner(on button: UIVisualEffectView) {
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.startAnimating()
    spinner.color = .label
    spinner.tag = ViewValues.tagIdentifierSpinner
    spinner.translatesAutoresizingMaskIntoConstraints = false
    button.contentView.addSubview(spinner)
    spinner.centerXY()
  }

  func hideSpinner(from button: UIVisualEffectView) {
    if let spinner = button.viewWithTag(ViewValues.tagIdentifierSpinner) as? UIActivityIndicatorView {
      UIView.animate(
        withDuration: 0.2,
        animations: { spinner.alpha = 0 },
        completion: { _ in
          spinner.removeFromSuperview()
        }
      )
    }
  }
}
