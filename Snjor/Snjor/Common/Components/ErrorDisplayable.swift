//
//  ErrorDisplayable.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.10.2024.
//

import UIKit

fileprivate typealias Const = ErrorDisplayableConst

protocol ErrorDisplayable: AnyObject {
  func showError(error: String, navigationController: UINavigationController?)
  func hideError()
}

// MARK: - Default method implementation
extension ErrorDisplayable where Self: UIViewController {
  
  // MARK: Internal Methods
  func showError(
    error: String,
    navigationController: UINavigationController? = nil
  ) {
    guard doesNotExistAnotherError else { return }
    configureError(
      error: error,
      navigationController: navigationController
    )
  }
  
  func hideError(){
    if let foundView = parentView.viewWithTag(Const.tagIdentifierError) {
      UIView.animate(withDuration: Const.hideErrorAnimateDuration) {
        foundView.alpha = .zero
      } completion: { _ in
        foundView.removeFromSuperview()
      }
    }
  }
  
  // MARK: Private Methods
  private var doesNotExistAnotherError: Bool {
    parentView.viewWithTag(Const.tagIdentifierError) == nil
  }
  
  private var parentView: UIView {
    return view
  }
  
  private func configureError(
    error: String,
    navigationController: UINavigationController? = nil
  ) {
    let containerView = UIView()
    containerView.tag = Const.tagIdentifierError
    parentView.addSubview(containerView)
    containerView.fillSuperView()
    containerView.backgroundColor = .black
    addErrorViewToContainer(
      containerView: containerView,
      error: error,
      navigationController: navigationController
    )
  }
  
  private func createErrorImageView() -> UIImageView {
    let errorImageView = UIImageView()
    errorImageView.contentMode = .scaleAspectFill
    errorImageView.tintColor = .systemRed
    errorImageView.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    errorImageView.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    return errorImageView
  }
  
  private func createErrorCodeLabel() -> UILabel {
    let errorCodeLabel = UILabel()
    errorCodeLabel.textAlignment = .center
    errorCodeLabel.numberOfLines = .zero
    errorCodeLabel.font = UIFont(name: .impact, size: Const.errorCodeLabelFontSize)
    return errorCodeLabel
  }
  
  private func createErrorLabel() -> UILabel {
    let errorLabel = UILabel()
    errorLabel.textColor = .white
    errorLabel.textAlignment = .center
    errorLabel.numberOfLines = .zero
    errorLabel.font = .systemFont(
      ofSize: Const.errorFontSize,
      weight: .black
    )
    return errorLabel
  }
  
  private func createErrorDetailLabel() -> UILabel {
    let errorDetailLabel = UILabel()
    errorDetailLabel.textColor = .white
    errorDetailLabel.textAlignment = .center
    errorDetailLabel.numberOfLines = .zero
    errorDetailLabel.font = .systemFont(
      ofSize: Const.errorDetailFontSize,
      weight: .medium
    )
    return errorDetailLabel
  }
  
  private func createCloseButton(
    navigationController: UINavigationController? = nil,
    closeIconImageView: UIImageView,
    closeIconBAckgroundView: UIView
  ) -> UIButton {
    let closeButton = UIButton()
    closeButton.backgroundColor = .clear
    closeButton.clipsToBounds = true
    closeButton.heightAnchor.constraint(
      equalToConstant: Const.closeIconSize
    ).isActive = true
    
    let closeButtonAction = UIAction { [weak self] _ in
      self?.animateButtonIcon(
        icon: closeIconImageView,
        iconBackground: closeIconBAckgroundView
      )
      DispatchQueue.main.asyncAfter(
        deadline: .now() + Const.navigationPopDelay
      ) {
        navigationController?.popViewController(animated: true)
        self?.hideError()
      }
    }
    
    closeButton.addAction(closeButtonAction, for: .touchUpInside)
    return closeButton
  }
  
  private func createCloseIconBackgroundView() -> UIView {
    let closeIconBAckgroundView = UIView()
    closeIconBAckgroundView.isUserInteractionEnabled = false
    closeIconBAckgroundView.backgroundColor = .systemGray6
    closeIconBAckgroundView.heightAnchor.constraint(
      equalToConstant: Const.closeIconBackgroundViewSize
    ).isActive = true
    closeIconBAckgroundView.widthAnchor.constraint(
      equalToConstant: Const.closeIconBackgroundViewSize
    ).isActive = true
    return closeIconBAckgroundView
  }
  
  private func createCloseIconImageView() -> UIImageView {
    let closeIconImageView = UIImageView()
    closeIconImageView.isUserInteractionEnabled = false
    closeIconImageView.image = SFSymbol.xmarkCircleIcon
    closeIconImageView.tintColor = .systemGray4
    closeIconImageView.heightAnchor.constraint(
      equalToConstant: Const.closeIconSize
    ).isActive = true
    closeIconImageView.widthAnchor.constraint(
      equalToConstant: Const.closeIconSize
    ).isActive = true
    return closeIconImageView
  }
  
  private func createErrorStackView(
    errorImageView: UIImageView,
    errorCodeLabel: UILabel,
    errorLabel: UILabel,
    errorDetailLabel: UILabel
  ) -> UIStackView {
    let errorStackView = UIStackView(
      arrangedSubviews: [
        errorImageView,
        errorCodeLabel,
        errorLabel,
        errorDetailLabel
      ]
    )
    errorStackView.alpha = Const.bigIconOpacity
    errorStackView.axis = .vertical
    errorStackView.alignment = .center
    errorStackView.spacing = Const.stackViewSpacing
    return errorStackView
  }
  
  private func createMainStackView(
    errorStackView: UIStackView,
    closeButton: UIButton
  ) -> UIStackView {
    let mainStackView = UIStackView(
      arrangedSubviews: [
        errorStackView,
        closeButton
      ]
    )
    mainStackView.axis = .vertical
    mainStackView.spacing = Const.stackViewSpacing
    return mainStackView
  }
  
  private func setupConstraints(
    containerView: UIView,
    mainStackView: UIStackView,
    closeButton: UIButton,
    closeIconBackgroundView: UIView,
    closeIconImageView: UIImageView
  ) {
    closeIconBackgroundView.setConstraints(
      centerY: closeButton.centerYAnchor,
      centerX: closeButton.centerXAnchor
    )
    closeIconImageView.centerXY()
    mainStackView.centerXY()
    mainStackView.setConstraints(
      right: containerView.rightAnchor,
      left: containerView.leftAnchor,
      pRight: Const.errorStackViewPaddingRight,
      pLeft: Const.errorStackViewPaddingLeft
    )
  }
  
  private func configureErrorLabels(
    errorCodeLabel: UILabel,
    errorLabel: UILabel,
    errorDetailLabel: UILabel,
    errorImageView: UIImageView,
    errorCode: Int,
    error: String
  ) {
    let errorInfo = getErrorInfo(for: errorCode, error: error)
    errorCodeLabel.text = errorInfo.title
    errorCodeLabel.textColor = errorInfo.color
    errorLabel.text = errorInfo.message
    errorDetailLabel.text = errorInfo.detail
    errorImageView.image = errorInfo.image
    errorImageView.tintColor = errorInfo.tintColor
  }
  
  private func addErrorViewToContainer(
    containerView: UIView,
    error: String,
    navigationController: UINavigationController? = nil
  ) {
    let errorImageView = createErrorImageView()
    let errorCodeLabel = createErrorCodeLabel()
    let errorLabel = createErrorLabel()
    let errorDetailLabel = createErrorDetailLabel()
    let closeIconBackgroundView = createCloseIconBackgroundView()
    let closeIconImageView = createCloseIconImageView()
    let closeButton = createCloseButton(
      navigationController: navigationController,
      closeIconImageView: closeIconImageView,
      closeIconBAckgroundView: closeIconBackgroundView
    )
    
    let errorStackView = createErrorStackView(
      errorImageView: errorImageView,
      errorCodeLabel: errorCodeLabel,
      errorLabel: errorLabel,
      errorDetailLabel: errorDetailLabel
    )
    
    let mainStackView = createMainStackView(
      errorStackView: errorStackView,
      closeButton: closeButton
    )
    
    containerView.addSubview(mainStackView)
    closeIconBackgroundView.addSubview(closeIconImageView)
    closeButton.addSubview(closeIconBackgroundView)
    
    setupConstraints(
      containerView: containerView,
      mainStackView: mainStackView,
      closeButton: closeButton,
      closeIconBackgroundView: closeIconBackgroundView,
      closeIconImageView: closeIconImageView
    )
    
    let errorCode = APIError.statusCode
    configureErrorLabels(
      errorCodeLabel: errorCodeLabel,
      errorLabel: errorLabel,
      errorDetailLabel: errorDetailLabel,
      errorImageView: errorImageView,
      errorCode: errorCode,
      error: error
    )
  }
  
  // MARK: Handle Error
  private func getErrorInfo(
    for code: Int,
    error: String
  ) -> (
    title: String,
    color: UIColor,
    message: String,
    detail: String,
    image: UIImage?,
    tintColor: UIColor
  ) {
    switch code {
    case Const.statusCode404:
      return (
        title: String(format: Const.errorTitleFormat, "\(code)"),
        color: Const.orangeColor,
        message: error,
        detail: Const.error404Message,
        image: SFSymbol.wifiExclamationmarkIcon,
        tintColor: Const.orangeColor
      )
    case Const.statusCode403:
      return (
        title: String(format: Const.errorTitleFormat, "\(code)"),
        color: Const.redColor,
        message: Const.requestLimitExceeded,
        detail: Const.error403Message,
        image: SFSymbol.exclamationmarkLockFillIcon,
        tintColor: Const.redColor
      )
    case Const.serverErrorCode:
      return (
        title: String(format: Const.errorTitleFormat, "\(code)"),
        color: Const.tealColor,
        message: error,
        detail: Const.serverErrorMessage,
        image: SFSymbol.exclamationmarkIcloudIcon,
        tintColor: Const.tealColor
      )
    default:
      return (
        title: String(format: Const.errorTitleFormat, "\(code)"),
        color: Const.redColor,
        message: error,
        detail: Const.defaultErrorDetail,
        image: SFSymbol.ladybugFillIcon,
        tintColor: Const.redColor
      )
    }
  }
  
  private func animateButtonIcon(icon: UIImageView, iconBackground: UIView) {
    UIView.animate(withDuration: Const.duration) {
      let scaleTransform = CGAffineTransform(
        scaleX: Const.pressingScale,
        y: Const.pressingScale
      )
      icon.transform = scaleTransform
      iconBackground.transform = scaleTransform
    } completion: { _ in
      UIView.animate(withDuration: Const.duration) {
        icon.transform = .identity
        iconBackground.transform = .identity
      }
    }
  }
}

// MARK: - Constants
private enum ErrorDisplayableConst {
  static let tagIdentifierError: Int = 123
  static let pressingScale: CGFloat = 0.8
  static let errorStackViewPaddingRight: CGFloat = 10.0
  static let errorStackViewPaddingLeft: CGFloat = 10.0
  static let closeIconSize: CGFloat = 40.0
  static let closeIconBackgroundViewSize = closeIconSize / 2
  static let errorFontSize: CGFloat = 30.0
  static let errorDetailFontSize: CGFloat = 20.0
  static let errorCodeLabelFontSize: CGFloat = 40.0
  static let navigationPopDelay: TimeInterval = 0.3
  static let bigIconSize: CGFloat = 150.0
  static let duration: CGFloat = 0.12
  static let stackViewSpacing: CGFloat = 16.0
  static let bigIconOpacity: CGFloat = 0.3
  static let hideErrorAnimateDuration: CGFloat = 0.15
  
  static let bigIconFontName: String = "Impact"
  static let errorTitleFormat: String = "Error %@".uppercased()
  
  // Error Messages
  static let error404Message: String = """
It might be unavailable or you may be offline. 
Please check your connection \nand try again.
"""
  static let error403Message: String = """
You've reached the maximum number of requests allowed. 
Please wait a moment and try again later.
"""
  static let serverErrorMessage: String = """
Something went wrong on our end. Please try again later. 
If the issue persists, contact support for assistance.
"""
  static let requestLimitExceeded: String = "Request Limit Exceeded"
  
  // Error Detail
  static let defaultErrorDetail: String = .empty
  
  // Colors
  static let orangeColor = UIColor.systemOrange
  static let redColor = UIColor.systemRed
  static let tealColor = UIColor.systemTeal
  
  // Status Codes
  static let statusCode404: Int = 404
  static let statusCode403: Int = 403
  static let serverErrorCode: ClosedRange<Int> = HTTPResponseStatus.serverError
}
