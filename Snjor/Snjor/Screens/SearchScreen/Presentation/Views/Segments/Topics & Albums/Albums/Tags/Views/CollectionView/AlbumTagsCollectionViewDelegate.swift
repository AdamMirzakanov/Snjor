//
//  AlbumTagsCollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 06.09.2024.
//

/// Делегат для обработки событий нажатия на ячейку тега.
protocol AlbumTagsCollectionViewDelegate: AnyObject {
    /// Метод, вызываемый при выборе тега в ячейке коллекции.
    /// - Parameter tag: Tег, который был выбран пользователем.
    func tagCellDidSelect(_ tag: Tag)
}

