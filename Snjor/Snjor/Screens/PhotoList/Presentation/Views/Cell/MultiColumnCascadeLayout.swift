//
//  MultiColumnCascadeLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 26.07.2024.
//

class MultiColumnCascadeLayout: CascadeLayout {
  
  override func prepare() {
    super.prepare()
    self.topInset = .zero
    self.headerAttributes.removeAll()
  }
  
  override func setUpDefaultOfColumns() {
    super.setUpDefaultOfColumns()
  }
}
