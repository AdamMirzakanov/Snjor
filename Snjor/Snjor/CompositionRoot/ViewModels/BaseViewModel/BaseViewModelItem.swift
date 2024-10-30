//
//  BaseViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Foundation

/// Структура `BaseViewModelItem` представляет собой обертку для элементов,
/// соответствующих протоколам `ViewModelItemRepresentable` и `Downloadable`.
///
/// Она предоставляет доступ к свойствам элемента и используется
/// для управления данными в представлении.
struct BaseViewModelItem<T: ViewModelItemRepresentable & Downloadable> {
  
  // MARK: - Internal Properties
  /// Элемент, который представляет собой объект типа `T`.
  private(set) var item: T
  
  /// Заголовок элемента, извлекаемый из свойства `title` элемента.
  var itemTitle: String { item.title }
   
  /// Уникальный идентификатор элемента, извлекаемый из свойства `id` элемента.
  var itemID: String { item.id }
  
  /// URL-адрес фотографии, извлекаемый из свойства `regularURL` элемента.
  var photoURL: URL? { item.regularURL }
}

