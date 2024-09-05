//
//  MainTabBarController.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
  
  // MARK: Private Properties
  private var selected: Int = .zero

  // Buttons
  private lazy var photoListButton = getButton(
    icon: "photos",
    tag: .zero,
    action: action,
    opacity: 1
  )

  private lazy var searchButton = getButton(
    icon: "search",
    tag: 1,
    action: action
  )

  private lazy var profileButton = getButton(
    icon: "search",
    tag: 2,
    action: action
  )

  private lazy var settingButton = getButton(
    icon: "slider.horizontal.below.square.filled.and.square",
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
      x: 16,
      y: view.bounds.height - 70,
      width: view.bounds.width - 32,
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
  }(UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial)))
  
  private lazy var gradientView: MainGradientView = {
    let color = UIColor(
      white: .zero,
      alpha: 1
    )
    $0.isUserInteractionEnabled = false
    $0.frame = CGRect(
      x: 0,
      y: view.bounds.height - 150,
      width: view.bounds.width ,
      height: 250
    )
    $0.setColors([
      MainGradientView.Color(
        color: .clear,
        location: 0.05
      ),
      MainGradientView.Color(
        color: color,
        location: 0.7
      )
    ])
    return $0
  }(MainGradientView())

  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(gradientView)
    view.addSubview(blurView)
    view.addSubview(customBar)
    
    tabBar.isHidden = true
  }

  // MARK: Internal  Methods
  func hideCustomTabBar() {
    UIView.animate(withDuration: 0.8) {
      self.customBar.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
      self.blurView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
    }
    
    UIView.animate(withDuration: 0.6) {
      self.gradientView.alpha = 0
    }
  }

  func showCustomTabBar() {
    UIView.animate(withDuration: 0.8) {
      self.customBar.transform = .identity
      self.blurView.transform = .identity
    }
    
    UIView.animate(withDuration: 1) {
      self.gradientView.alpha = 1
    }
  }
  
  // MARK: Private Methods
  private func getButton(
    icon: String,
    tag: Int,
    action: UIAction,
    opacity: Float = 0.4
  ) -> UIButton {
    return {
      $0.setImage(UIImage(named: icon), for: .normal)
      $0.widthAnchor.constraint(
        equalToConstant: 22
      ).isActive = true
      $0.heightAnchor.constraint(
        equalToConstant: 22
      ).isActive = true
      $0.tintColor = .label
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
