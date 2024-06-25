//
//  SpinnerDisplayable.swift
//  Snjor
//
//  Created by Адам on 24.06.2024.
//

import UIKit

protocol SpinnerDisplayable: AnyObject {
  func showSpinner()
  func hideSpinner()
}

extension SpinnerDisplayable where Self: UIViewController {
  func showSpinner() {
    guard doesNotExistAnotherSpinner else { return }
    configureSpinner()
  }

  private func configureSpinner() {
    let containerView = UIView()
    containerView.tag = ViewValues.tagIdentifierSpinner
    parentView.addSubview(containerView)
    containerView.fillSuperView()
    containerView.backgroundColor = .systemBackground
    addSpinnerIndicatorToContainer(containerView: containerView)
  }

  private func addSpinnerIndicatorToContainer(containerView: UIView) {
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.startAnimating()
    spinner.color = .systemGray
    containerView.addSubview(spinner)
    spinner.centerXY()
  }

  func hideSpinner() {
    if let foundView = parentView.viewWithTag(ViewValues.tagIdentifierSpinner) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
        foundView.removeFromSuperview()
      }
    }
  }

  private var doesNotExistAnotherSpinner: Bool {
    parentView.viewWithTag(ViewValues.tagIdentifierSpinner) == nil
  }

  private var parentView: UIView {
    navigationController?.topViewController?.view ?? view
  }
}
