//
//  MainTabBarController.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

fileprivate typealias Const = MainTabBarControllerConst

/// `MainTabBarController` является кастомным таб-бар контроллером, который управляет
/// пользовательским интерфейсом навигации между основными экранами приложения.
/// В этом классе реализованы методы для отображения и скрытия кастомного таб-бара,
/// а также управления его состоянием.
final class MainTabBarController: UITabBarController {
  
  // MARK: Private Properties
  private var selected: Int = .zero // Индекс выбранной вкладки
  
  // Кнопки таб-бара
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
  
  // Действие, выполняемое при нажатии на кнопку
  private lazy var action = UIAction { [weak self] sender in
    guard
      let sender = sender.sender as? UIButton,
      let self = self
    else {
      return
    }
    self.selectedIndex = sender.tag     // Апдейт выбранного индекса
    self.selected = self.selectedIndex
    self.setOpacity(tag: sender.tag)    // Задать прозрачность кнопок
    self.animateButton(sender)
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
    $0.addArrangedSubview(UIView())       // Распорка слева
    $0.addArrangedSubview(photosButton)
    $0.addArrangedSubview(searchButton)
    $0.addArrangedSubview(settingsButton)
    $0.addArrangedSubview(UIView())       // Распорка справа
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
  
  // MARK: Internal Methods
  /// Скрывает кастомный таб-бар с анимацией.
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
  
  /// Показывает кастомный таб-бар с анимацией.
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
    tabBar.isHidden = true // Скрыть стандартный таб-бар
  }
  
  /// Создает кнопку с заданным иконкой, тегом и действием.
  ///
  /// - Parameters:
  ///   - icon: Имя изображения для иконки кнопки (сторонние иконки добавлены в ресурсы).
  ///   - tag: Тег кнопки, используемый для определения выбранного индекса.
  ///   - action: Действие, выполняемое при нажатии на кнопку.
  ///   - opacity: Прозрачность кнопки (по умолчанию `defaultOpacity`).
  /// - Returns: Настроенная кнопка.
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
  
  /// Устанавливает прозрачность кнопок в зависимости от выбранного тега.
  ///
  /// - Parameter tag: Текущий тег выбранной кнопки.
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
  
  // MARK: Animate TabBar Buttons
  private func animateButton(_ sender: UIButton) {
    UIView.animate(withDuration: Const.duration) {
      let scaleTransform = CGAffineTransform(
        scaleX: Const.pressingScale,
        y: Const.pressingScale
      )
      sender.transform = scaleTransform
    } completion: { _ in
      UIView.animate(withDuration: Const.duration) {
        sender.transform = .identity
      }
    }
  }
}
