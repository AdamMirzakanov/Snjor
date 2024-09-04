//
//  CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

import Foundation

protocol CascadeLayoutDelegate: AnyObject {
  func cascadeLayout(
    _ layout: any CascadeLayoutConformable,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize
}
