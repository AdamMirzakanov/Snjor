//
//  AlbumPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

protocol AlbumPhotoCellDelegate: AnyObject {
  func downloadTapped(_ cell: AlbumPhotoCell)
}

final class AlbumPhotoCell: MainPhotoCell {
  
  // MARK: - Delegate
  weak var delegate: (any AlbumPhotoCellDelegate)?
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    mainView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
