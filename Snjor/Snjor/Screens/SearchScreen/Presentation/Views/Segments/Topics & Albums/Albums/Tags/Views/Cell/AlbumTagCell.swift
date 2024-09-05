//
//  AlbumTagCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

final class AlbumTagCell: MainTagCell {
  override func configTagLabel() {
    super.configTagLabel()
    tagLabel.textColor = .label
    tagLabel.alpha = MainTagCellConst.tagLabelOpacity
    tagLabel.backgroundColor = .systemGray4
  }
}
