//
//  AlbumCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

/// Делегат для обработки событий нажатия на ячейку тега.
protocol AlbumCellDelegate: AnyObject {
  /// Метод, вызываемый при выборе тега в ячейке коллекции.
  /// - Parameter tag: Tег, который был выбран пользователем.
  ///
  /// Вызывается аналогичным методом делегата `AlbumTagsCollectionViewDelegate`
  func tagCellDidSelect(_ tag: Tag)
}
