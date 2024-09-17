//
//  UserProfileCascadeLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.09.2024.
//

import Foundation

final class UserProfileCascadeLayout: CascadeLayout {
  override init(with delegate: (any CascadeLayoutDelegate)?) {
    super.init(with: delegate)
    columnSpacing = 10.0
    numberOfColumns = 3
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
