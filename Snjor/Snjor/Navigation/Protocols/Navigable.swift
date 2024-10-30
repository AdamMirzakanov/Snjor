//
//  Navigable.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

/// Протокол определяет набор требований для координаторов,
/// которые управляют навигацией между экранами приложения
/// с помощью `UINavigationController`.
protocol Navigable {
  
  // MARK: Properties
  /// Основной навигационный контроллер.
  var rootViewController: UINavigationController { get }
  
  /// Навигационная панель, связанная с `rootViewController`.
  var navigationBar: UINavigationBar { get }
  
  /// Массив контроллеров, управляемых навигационным контроллером.
  var viewControllers: [UIViewController] { get set }
  
  /// Замыкание, вызываемое при завершении операции закрытия (dismiss).
  var dismissNavigation: (() -> Void)? { get set }
  
  // MARK: Methods
  /// Представляет переданный вью-контроллер модально.
  /// - Parameters:
  ///   - viewController: Контроллер, который нужно представить.
  ///   - animated: Флаг, указывающий, следует ли использовать анимацию.
  func present(
    _ viewController: UIViewController,
    animated: Bool
  )
  
  /// Выполняет навигацию с переходом на указанный `UIViewController`.
  /// - Parameters:
  ///   - viewControllerToPresent: Контроллер, который нужно показать.
  ///   - animated: Флаг, указывающий, следует ли использовать анимацию.
  ///   - backCompletion: Замыкание, вызываемое после возврата (опционально).
  func pushViewController(
    _ viewControllerToPresent: UIViewController,
    animated: Bool,
    backCompletion: (() -> Void)?
  )
  
  /// Закрывает текущий модально представленный контроллер.
  /// - Parameter animated: Флаг, указывающий, следует ли использовать анимацию.
  func dismiss(animated: Bool)
}

// MARK: - Default method implementation
extension Navigable {
  /// Реализация метода `pushViewController` без параметра `backCompletion`.
  /// - Parameters:
  ///   - viewControllerToPresent: Контроллер, который нужно показать.
  ///   - animated: Флаг, указывающий, следует ли использовать анимацию.
  func pushViewController(
    _ viewControllerToPresent: UIViewController,
    animated: Bool
  ) {
    pushViewController(
      viewControllerToPresent,
      animated: animated,
      backCompletion: nil
    )
  }
}
