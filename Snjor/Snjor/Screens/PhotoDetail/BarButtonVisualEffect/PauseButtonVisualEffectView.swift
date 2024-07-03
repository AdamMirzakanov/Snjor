//
//  PauseButtonVisualEffectView.swift
//  Snjor
//
//  Created by Адам on 03.07.2024.
//

import UIKit

//class PauseButtonVisualEffectView {
//
//  let pauseBarButtonBlurView: UIVisualEffectView = {
//    $0.frame.size.height = UIConst.buttonHeight
//    $0.layer.cornerRadius = UIConst.defaultValue
//    $0.clipsToBounds = true
//    return $0
//  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
//
//  lazy var pauseBarButton: UIButton = {
//    $0.setImage(UIImage(systemName: .pauseBarButtonImage), for: .normal)
//    $0.tintColor = .label
//    $0.alpha = UIConst.alpha
//    $0.frame = pauseBarButtonBlurView.bounds
//    return $0
//  }(UIButton(type: .custom))
//
//  func makePauseBarButton() -> UIBarButtonItem {
//    setupView()
//    pauseBarButtonBlurView.isHidden = true
//    return UIBarButtonItem(customView: pauseBarButtonBlurView)
//  }
//
//  private func setupView() {
//    pauseBarButtonBlurView.contentView.addSubview(pauseBarButton)
//  }
//}
