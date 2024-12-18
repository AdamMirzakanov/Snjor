//
//  PhotoListCell.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

final class SearchScreenPhotoCell: MainPhotoCell {
  weak var delegate: (any SearchScreenPhotoCellDelegate)?
  
  override func setupDelegate() {
    rootView.mainView.delegate = self
  }
}
