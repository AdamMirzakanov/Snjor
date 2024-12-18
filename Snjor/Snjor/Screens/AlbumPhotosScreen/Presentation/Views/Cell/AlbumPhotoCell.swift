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
  
  override func setupDelegate() {
    rootView.mainView.delegate = self
  }
}
