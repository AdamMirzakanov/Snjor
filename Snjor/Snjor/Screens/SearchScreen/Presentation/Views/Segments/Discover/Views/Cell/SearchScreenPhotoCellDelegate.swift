//
//  SearchScreenPhotoCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

/// Делегат для обработки событий взаимодействия с ячейкой `SearchScreenPhotoCell`.
///
/// Этот протокол предназначен для передачи событий от ячейки фотографии
/// к бъекту, который будет обрабатывать нажатия на кнопку загрузки.
protocol SearchScreenPhotoCellDelegate: AnyObject {
  /// Метод, вызываемый при нажатии на кнопку загрузки в ячейке.
  /// - Parameter cell: Ячейка, в которой произошло нажатие.
  func downloadTapped(_ cell: SearchScreenPhotoCell)
}
