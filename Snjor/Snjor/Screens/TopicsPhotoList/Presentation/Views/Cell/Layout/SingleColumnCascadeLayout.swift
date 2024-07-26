//
//  SingleColumnCascadeLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 26.07.2024.
//

class SingleColumnCascadeLayout: CascadeLayout {
  override func setUpDefaultOfColumns() {
    numberOfColumns = CascadeLayoutConst.singleColumns
  }
}
