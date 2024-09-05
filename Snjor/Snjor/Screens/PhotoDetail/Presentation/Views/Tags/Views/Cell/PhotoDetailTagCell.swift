//
//  PhotoDetailTagCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

final class PhotoDetailTagCell: MainTagCell {
  override func configTagLabel() {
    super.configTagLabel()
    tagLabel.backgroundColor = .white
    tagLabel.textColor = .black
  }
}
