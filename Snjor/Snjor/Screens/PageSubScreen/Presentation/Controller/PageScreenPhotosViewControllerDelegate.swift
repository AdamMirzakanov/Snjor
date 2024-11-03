//
//  PageScreenPhotosViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

/// Протокол, определяющий делегат для управления событиями выбора ячейки в контроллере фотографий.
/// - Используется для уведомления делегата о том, что ячейка с фотографией была выбрана.
/// - Протокол должен быть реализован классами, которые хотят реагировать на выбор ячейки.
protocol PageScreenPhotosViewControllerDelegate: AnyObject {
    /// Вызывается при выборе ячейки с фотографией.
    /// - Parameter photo: Объект `Photo`, который был выбран.
    func didSelectCell(_ photo: Photo)
}
