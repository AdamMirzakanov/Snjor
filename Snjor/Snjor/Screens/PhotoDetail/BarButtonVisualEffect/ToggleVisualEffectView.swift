//
//  ToggleVisualEffectView.swift
//  Snjor
//
//  Created by Адам on 03.07.2024.
//

import UIKit

//class ToggleVisualEffectView {
//
//  let toggleContentModeButtonBlurView: UIVisualEffectView = {
//    $0.frame.size.width = UIConst.buttonHeight
//    $0.frame.size.height = UIConst.buttonHeight
//    $0.layer.cornerRadius = UIConst.defaultValue
//    $0.clipsToBounds = true
//    return $0
//  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
//
//  lazy var toggleContentModeButton: UIButton = {
//    let icon = UIImage(systemName: .arrowUp)
//    $0.setImage(icon, for: .normal)
//    $0.tintColor = .label
//    $0.setTitleColor(.label, for: .normal)
//    $0.alpha = UIConst.alpha
//    $0.frame = toggleContentModeButtonBlurView.bounds
//    return $0
//  }(UIButton(type: .custom))
//
//  func makeToggleContentModeButton() -> UIBarButtonItem {
//    setupView()
//    return UIBarButtonItem(customView: toggleContentModeButtonBlurView)
//  }
//
//  private func setupView() {
//    toggleContentModeButtonBlurView.contentView.addSubview(toggleContentModeButton)
//  }
//}
