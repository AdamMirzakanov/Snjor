//
//  AlbumPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

final class AlbumPhotoCell: MainPhotoCell {
  
  // MARK: Delegate
  weak var delegate: (any AlbumPhotoCellDelegate)?
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    mainView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
}
