//
//  BarButtonViews.swift
//  Snjor
//
//  Created by Адам on 03.07.2024.
//

import UIKit

class BarButtonViews {

  // MARK: - Back Bar Button
  let backBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = UIConst.buttonHeight
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.backButtonBlurViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  lazy var backBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .backBarButtonImage), for: .normal)
    $0.tintColor = .label
    $0.alpha = UIConst.alpha
    $0.frame = backBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: - Download Bar Button
  let downloadBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = UIConst.buttonWidth
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  lazy var downloadBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .downloadBarButtonImage), for: .normal)
    $0.setTitle(.jpeg, for: .normal)
    $0.titleLabel?.font = .systemFont(
      ofSize: UIConst.defaultFontSize,
      weight: .regular
    )
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alpha
    $0.frame = downloadBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: - Pause Bar Button
  let pauseBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  lazy var pauseBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .pauseBarButtonImage), for: .normal)
    $0.tintColor = .label
    $0.alpha = UIConst.alpha
    $0.frame = pauseBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  func makePauseBarButton() -> UIBarButtonItem {
    pauseBarButtonBlurView.isHidden = true
    return UIBarButtonItem(customView: pauseBarButtonBlurView)
  }

  // MARK: - Toggle Bar Button
  let toggleContentModeButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = UIConst.buttonHeight
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  lazy var toggleContentModeButton: UIButton = {
    let icon = UIImage(systemName: .arrowUp)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alpha
    $0.frame = toggleContentModeButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: - M
  func setupBarButtonView() {
    backBarButtonBlurView.contentView.addSubview(backBarButton)
    downloadBarButtonBlurView.contentView.addSubview(downloadBarButton)
    pauseBarButtonBlurView.contentView.addSubview(pauseBarButton)
    toggleContentModeButtonBlurView.contentView.addSubview(toggleContentModeButton)
  }

  func makeRightBackBarButtons() -> [UIBarButtonItem] {
    let downloadBarButton = UIBarButtonItem(customView: downloadBarButtonBlurView)
    let pauseBarButton = makePauseBarButton()
    let toggleContentModeButton = UIBarButtonItem(customView: toggleContentModeButtonBlurView)
    let barButtonItems = [toggleContentModeButton, downloadBarButton, pauseBarButton]
    return barButtonItems
  }

  func makeLeftBackBarButtons() -> [UIBarButtonItem] {
    let backBarButton = UIBarButtonItem(customView: backBarButtonBlurView)
    let barButtonItems = [backBarButton]
    return barButtonItems
  }
}
