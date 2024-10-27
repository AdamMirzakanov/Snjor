//
//  CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 27.10.2024.
//

import Foundation

protocol CascadeLayoutDelegate: AnyObject {
  func cascadeLayout(
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize
}
