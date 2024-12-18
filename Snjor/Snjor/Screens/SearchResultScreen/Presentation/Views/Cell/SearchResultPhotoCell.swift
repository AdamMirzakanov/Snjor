//
//  SearchResultPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.10.2024.
//

import UIKit

final class SearchResultPhotoCell: MainPhotoCell {
  weak var delegate: (any SearchResultPhotoCellDelegate)?
  
  override func setupDelegate() {
    rootView.mainView.delegate = self
  }
}
