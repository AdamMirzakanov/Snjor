//
//  BaseViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Foundation

struct BaseViewModelItem<T: ViewModelItemRepresentable & Downloadable> {
  private(set) var item: T
  var itemTitle: String { item.title }
  var itemID: String { item.id }
  var photoURL: URL? { item.regularURL }
}
