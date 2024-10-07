//
//  SecondCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

import Foundation

protocol SecondCellDelegate: AnyObject {
  func secondCellDidSelectItem(at indexPath: IndexPath)
}
