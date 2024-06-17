//
//  MainTabBarController.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
  // MARK: - Private Properties
  private var selected = Int.zero

  // Buttons
  private lazy var photoListButton = getButton(
    icon: "photo.on.rectangle.angled",
    tag: Int.zero,
    action: action,
    opacity: 1
  )

  private lazy var searchButton = getButton(
    icon: "magnifyingglass",
    tag: 1,
    action: action
  )

  private lazy var profileButton = getButton(
    icon: "person",
    tag: 2,
    action: action
  )

  private lazy var settingButton = getButton(
    icon: "gearshape",
    tag: 3,
    action: action
  )

  private lazy var action = UIAction { [weak self] sender in
    guard let sender = sender.sender as? UIButton, let self = self
    else { return }
    self.selectedIndex = sender.tag
    self.selected = self.selectedIndex
    self.setOpacity(tag: sender.tag)
  }

  private lazy var customBar: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.alignment = .center
    $0.frame = CGRect(
      x: 20,
      y: view.bounds.height - 70,
      width: view.bounds.width - 40,
      height: 50
    )
    $0.layer.cornerRadius = tabBar.bounds.height / 2
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(photoListButton)
    $0.addArrangedSubview(searchButton)
    $0.addArrangedSubview(profileButton)
    $0.addArrangedSubview(settingButton)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  private lazy var blurView: UIVisualEffectView = {
    $0.frame = customBar.frame
    $0.layer.cornerRadius = customBar.layer.cornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial)))

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(blurView)
    view.addSubview(customBar)
    tabBar.isHidden = true
  }

  // MARK: - Private Methods
  private func getButton(
    icon: String,
    tag: Int,
    action: UIAction,
    opacity: Float = 0.4
  ) -> UIButton {
    return {
      $0.setImage(UIImage(systemName: icon), for: .normal)
      $0.tintColor = .systemMint
      $0.layer.opacity = opacity
      $0.tag = tag
      return $0
    }(UIButton(primaryAction: action))
  }

  private func setOpacity(tag: Int) {
    [photoListButton, searchButton, profileButton, settingButton].forEach { button in
      if button.tag != tag {
        button.layer.opacity = 0.4
      } else {
        button.layer.opacity = 1.0
      }
    }
  }
}
