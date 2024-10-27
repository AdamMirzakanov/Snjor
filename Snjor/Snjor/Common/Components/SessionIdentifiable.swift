//
//  SessionIdentifiable.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

/// Добавляет вычисляемое свойство  которое возвращает строку,
/// представляющую идентификатор сессии.
protocol SessionIdentifiable: AnyObject { }

extension SessionIdentifiable {
  /// Вычисляемое свойство `sessionID` которое возвращает строку,
  /// представляющую идентификатор сессии.
  /// Этот идентификатор создается на основе имени класса, соответствующей протоколу
  static var sessionID: String {
    return String(describing: self)
  }
}
