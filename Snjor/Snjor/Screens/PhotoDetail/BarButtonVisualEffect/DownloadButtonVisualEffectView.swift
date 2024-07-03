//
//  DownloadButtonVisualEffectView.swift
//  Snjor
//
//  Created by Адам on 03.07.2024.
//

import UIKit

//class DownloadButtonVisualEffectView {
//
//  let downloadBarButtonBlurView: UIVisualEffectView = {
//    $0.frame.size.width = UIConst.buttonWidth
//    $0.frame.size.height = UIConst.buttonHeight
//    $0.layer.cornerRadius = UIConst.defaultValue
//    $0.clipsToBounds = true
//    return $0
//  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
//
//  lazy var downloadBarButton: UIButton = {
//    $0.setImage(UIImage(systemName: .downloadBarButtonImage), for: .normal)
//    $0.setTitle(.jpeg, for: .normal)
//    $0.titleLabel?.font = .systemFont(
//      ofSize: UIConst.defaultFontSize,
//      weight: .regular
//    )
//    $0.tintColor = .label
//    $0.setTitleColor(.label, for: .normal)
//    $0.alpha = UIConst.alpha
//    $0.frame = downloadBarButtonBlurView.bounds
//    return $0
//  }(UIButton(type: .custom))
//
//  func makeDownloadBarButton() -> UIBarButtonItem {
//    setupView()
//    return UIBarButtonItem(customView: downloadBarButtonBlurView)
//  }
//
//  private func setupView() {
//    downloadBarButtonBlurView.contentView.addSubview(downloadBarButton)
//  }
//}
