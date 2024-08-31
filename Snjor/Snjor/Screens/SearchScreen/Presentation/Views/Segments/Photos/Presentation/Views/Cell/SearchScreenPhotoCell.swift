//
//  PhotoListCell.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol SearchScreenPhotoCellDelegate: AnyObject {
  func downloadTapped(_ cell: SearchScreenPhotoCell)
}

final class SearchScreenPhotoCell: PhotoCell {
  
  // MARK: - Delegate
  weak var delegate: (any SearchScreenPhotoCellDelegate)?

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    mainView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
