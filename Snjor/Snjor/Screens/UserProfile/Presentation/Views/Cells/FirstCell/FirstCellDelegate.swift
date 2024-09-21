//
//  FirstCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

import Foundation

protocol FirstCellDelegate: AnyObject {
  func firstCellDidSelectItem(at indexPath: IndexPath)
}
