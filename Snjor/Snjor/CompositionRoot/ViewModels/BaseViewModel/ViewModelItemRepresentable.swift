//
//  ViewModelItemRepresentable.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Foundation

/// Протокол `ViewModelItemRepresentable` определяет
/// основные свойства, которые должен иметь элемент `ViewModel`.
///
/// Протокол используется для представления объектов,
/// содержащих идентификатор, заголовок и URL-адрес.
protocol ViewModelItemRepresentable {
  
  // MARK: - Internal Properties
  /// URL-адрес элемента (фотографии, разрешение которой `regular`).
  ///
  /// - Note: API предоставляет несколько размеров на выбор
  /// (`raw`, `full`, `regular`, `small` и `thumb`)
  var regularURL: URL? { get }
  
  /// Уникальный идентификатор элемента.
  var id: String { get }
  
  /// Заголовок элемента.
  var title: String { get }
}
