//
//  SearchResultPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.10.2024.
//

import UIKit

final class SearchResultPhotoCell: MainPhotoCell {
  // MARK: Delegate
  weak var delegate: (any SearchResultPhotoCellDelegate)?
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    mainView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
}
