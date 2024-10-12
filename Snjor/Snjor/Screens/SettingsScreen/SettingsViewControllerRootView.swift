//
//  SettingsViewControllerRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.10.2024.
//

import UIKit

final class SettingsViewControllerRootView: UIView {
  
  // MARK: Views
  private let switcher: UISwitch = {
    $0.onTintColor = .systemRed
    return $0
  }(UISwitch())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
    
    switcher.addTarget(
      self,
      action: #selector(switchChanged),
      for: .valueChanged
    )
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(switcher)
  }
  
  private func setupConstraints() {
    switcher.centerXY()
  }
  
  @objc private func switchChanged(_ sender: UISwitch) {
    let selectedOrientation: String
    if sender.isOn {
      selectedOrientation = "landscape"
    } else {
      selectedOrientation = "squarish"
    }
    UserDefaults.standard.set(selectedOrientation, forKey: "photoOrientation")
  }
}
