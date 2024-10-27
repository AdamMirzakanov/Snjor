//
//  CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 27.10.2024.
//

import Foundation

protocol CascadeLayoutDelegate: AnyObject {
  /// Метод, который должен быть реализован делегатом.
  /// Он принимает `indexPath` и возвращает размер элемента в виде `CGSize`.
  /// Это позволяет макету динамически получать размеры ячеек.
  func cascadeLayout(
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize
}
