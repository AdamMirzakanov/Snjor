//
//  ViewLoadable.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

/// Протокол который определяет ассоциированный тип `RootView`,
/// представляющий собой корневое представление, наследуемое от `UIView`.
protocol ViewLoadable {
  associatedtype RootView: UIView
  func resolveRootView() -> RootView?
}

// MARK: - Default Implementation
extension ViewLoadable {
  /// Свойство `rootView`, обеспечивающее доступ к корневому
  /// представлению типа `RootView`, которое должно быть установлено.
  var rootView: RootView {
    guard let customView = resolveRootView() else {
      fatalError(errorMessage)
    }
    return customView
  }
}

// MARK: - UIViewController
extension ViewLoadable where Self: UIViewController {
  func resolveRootView() -> RootView? {
    return view as? RootView
  }
}

// MARK: - UICollectionViewCell
extension ViewLoadable where Self: UICollectionViewCell {
  func resolveRootView() -> RootView? {
    return contentView.subviews.first as? RootView
  }
}

// MARK: - Error Message
private extension ViewLoadable {
  /// Сообщение об ошибке при несоответствии типов.
  var errorMessage: String {
    String(
      format: ErrorMessage.errorTemplate,
      String(describing: RootView.self),
      String(describing: resolveRootViewType())
    )
  }
  
  /// Получить тип `view` для описания ошибки.
  func resolveRootViewType() -> Any.Type {
    guard let resolvedView = resolveRootView() else {
      return UIView.self
    }
    return type(of: resolvedView)
  }
}
