//
//  MainTabBarController.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

fileprivate typealias Const = MainTabBarControllerConst

final class MainTabBarController: UITabBarController {
  
  // MARK: Private Properties
  private var selected: Int = .zero
  
  // Buttons
  private lazy var photosButton = getButton(
    icon: Const.photosButtonIcon,
    tag: Const.photoListButtonTag,
    action: action,
    opacity: Float(Const.maxOpacity)
  )
  
  private lazy var searchButton = getButton(
    icon: Const.searchButtonIcon,
    tag: Const.searchButtonTag,
    action: action
  )
  
  private lazy var settingsButton = getButton(
    icon: Const.settingsButtonIcon,
    tag: Const.settingsButtonTag,
    action: action
  )
  
  private lazy var action = UIAction { [weak self] sender in
    guard
      let sender = sender.sender as? UIButton,
      let self = self
    else {
      return
    }
    self.selectedIndex = sender.tag
    self.selected = self.selectedIndex
    self.setOpacity(tag: sender.tag)
  }
  
  // MARK: Views
  private lazy var customBar: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.alignment = .center
    $0.frame = CGRect(
      x: Const.customBarHorizontalInset,
      y: view.bounds.height - Const.customBarVerticalInset,
      width: view.bounds.width - 2 * Const.customBarHorizontalInset,
      height: Const.customBarHeight
    )
    $0.layer.cornerRadius = $0.bounds.height / 2
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(photosButton)
    $0.addArrangedSubview(searchButton)
    $0.addArrangedSubview(settingsButton)
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
      alpha: Const.maxOpacity
    )
    $0.isUserInteractionEnabled = false
    $0.frame = CGRect(
      x: .zero,
      y: view.bounds.height - Const.gradientViewYPosition,
      width: view.bounds.width,
      height: Const.gradientViewHeight
    )
    $0.setColors([
      MainGradientView.Color(
        color: .clear,
        location: Const.firstColorLocation
      ),
      MainGradientView.Color(
        color: color,
        location: Const.secondColorLocation
      )
    ])
    return $0
  }(MainGradientView())
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    defaultTabBarConfigurations()
  }
  
  // MARK: Internal  Methods
  func hideCustomTabBar() {
    UIView.animate(withDuration: Const.hideTabBarAnimationDuration) {
      self.customBar.transform = CGAffineTransform(
        translationX: .zero,
        y: self.view.bounds.height
      )
      self.blurView.transform = CGAffineTransform(
        translationX: .zero,
        y: self.view.bounds.height
      )
    }
    
    UIView.animate(withDuration: Const.showTabBarAnimationDuration) {
      self.gradientView.alpha = .zero
    }
  }
  
  func showCustomTabBar() {
    UIView.animate(withDuration: Const.hideTabBarAnimationDuration) {
      self.customBar.transform = .identity
      self.blurView.transform = .identity
    }
    UIView.animate(withDuration: Const.gradientViewShowDuration) {
      self.gradientView.alpha = Const.maxOpacity
    }
  }
  
  // MARK: Private Methods
  private func addSubviews() {
    view.addSubview(gradientView)
    view.addSubview(blurView)
    view.addSubview(customBar)
  }
  
  private func defaultTabBarConfigurations() {
    tabBar.isHidden = true
  }
  
  private func getButton(
    icon: String,
    tag: Int,
    action: UIAction,
    opacity: Float = Float(Const.defaultOpacity)
  ) -> UIButton {
    return {
      $0.setImage(UIImage(named: icon), for: .normal)
      $0.widthAnchor.constraint(equalToConstant: Const.buttonSize).isActive = true
      $0.heightAnchor.constraint(equalToConstant: Const.buttonSize).isActive = true
      $0.tintColor = .label
      $0.layer.opacity = opacity
      $0.tag = tag
      return $0
    }(UIButton(primaryAction: action))
  }
  
  private func setOpacity(tag: Int) {
    [
      photosButton,
      searchButton,
      settingsButton
    ].forEach {
      if $0.tag != tag {
        $0.layer.opacity = Float(Const.defaultOpacity)
      } else {
        $0.layer.opacity = Float(Const.maxOpacity)
      }
    }
  }
}
