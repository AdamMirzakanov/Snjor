//
//  PhotoListCell.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

final class SearchScreenPhotoCell: MainPhotoCell {
  // MARK: Delegate
  weak var delegate: (any SearchScreenPhotoCellDelegate)?

  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    mainView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
}
