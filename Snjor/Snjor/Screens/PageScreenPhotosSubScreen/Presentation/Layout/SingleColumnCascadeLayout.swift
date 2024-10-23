//
//  SingleColumnCascadeLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 26.07.2024.
//

import UIKit

fileprivate typealias Const = CascadeLayoutConst

final class SingleColumnCascadeLayout: CascadeLayout {
  override func setUpDefaultOfColumns() {
    numberOfColumns = Const.singleColumns
    columnSpacing = Const.columnSpacing
  }
}
