//
//  UserPhotosCascadeLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.09.2024.
//

import Foundation

fileprivate typealias Const = UserPhotosCascadeLayoutConst

final class UserPhotosCascadeLayout: CascadeLayout {
  override init(with delegate: (any CascadeLayoutDelegate)?) {
    super.init(with: delegate)
    columnSpacing = Const.columnSpacing
    numberOfColumns = Const.numberOfColumns
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
}
