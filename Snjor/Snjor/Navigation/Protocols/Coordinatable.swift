//
//  Coordinatable.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

/// Протокол `Coordinatable` определяет общие требования для координаторов,
/// которые управляют навигацией и жизненным циклом экранов в приложении.
///
/// Координаторы используют объект, соответствующий `Navigable`,
/// для выполнения навигации и организации переходов.
protocol Coordinatable: AnyObject {
  
  /// Свойство, которое предоставляет объект, управляющий навигацией.
  var navigation: any Navigable { get set }
  
  /// Этот метод вызывается для инициализации работы координатора
  func start()
}