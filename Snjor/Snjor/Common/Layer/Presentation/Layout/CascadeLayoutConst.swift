//
//  CascadeLayoutConst.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

enum CascadeLayoutConst {
  static var headerHeight: CGFloat = 100.0
  static let topInset: CGFloat = headerHeight + getAdjustedSpacing()
  static let singleColumns = 1
  static let iPhoneColumns = 2
  static let iPadColumns = 3
  static let columnSpacing = getAdjustedSpacing()
  
  /// Возвращает скорректированное значение зазора между столбцами в зависимости от ширины экрана.
  /// Если ширина экрана чётная, зазор составляет - 2, в противном случае - 3.
  ///
  /// Если ширина экрана имеет четное значение и при этом зазор между столбиками имеет
  /// не четное значение то ячейки с правого края экрана плотно не прилягают к краю,
  /// оставляя небольшой отступ равный примерно одному пикселю,
  /// во избежание этого четность зазора расчитывается динамически.
  ///
  /// - Returns: Значение зазора между столбцами в виде `CGFloat`.
  ///
  /// - Note: Этот эффект заметен только на светлом фоне.
  static func getAdjustedSpacing() -> CGFloat {
    let screenWidth = Int(UIScreen.main.bounds.width)
    return screenWidth % 2 == 0 ? 2 : 3
  }
}
