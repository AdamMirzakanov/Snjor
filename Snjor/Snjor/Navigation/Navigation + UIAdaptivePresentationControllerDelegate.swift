//
//  Navigation + UIAdaptivePresentationControllerDelegate.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

extension Navigation: UIAdaptivePresentationControllerDelegate {
  
  /// Метод вызывается, когда представленный (модальный) вью-контроллер был закрыт пользователем.
  ///
  /// - Parameter presentationController: Контроллер, управляющий модальным представлением.
  func presentationControllerDidDismiss(
    _ presentationController: UIPresentationController
  ) {
    // Выполняем замыкание `dismissNavigation` (если оно задано) и освобождаем его.
    dismissNavigation?()
    dismissNavigation = nil
  }
}
