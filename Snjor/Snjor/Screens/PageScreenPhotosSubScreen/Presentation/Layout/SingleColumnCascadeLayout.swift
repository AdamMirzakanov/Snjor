//
//  SingleColumnCascadeLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 26.07.2024.
//

import UIKit

final class SingleColumnCascadeLayout: CascadeLayout {  
  override func setUpDefaultOfColumns() {
    numberOfColumns = CascadeLayoutConst.singleColumns
    columnSpacing = CascadeLayoutConst.columnSpacing
  }
}
