//
//  AlbumTagCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

fileprivate typealias Const = MainTagCellConst

final class AlbumTagCell: MainTagCell {
  override func configTagLabel() {
    super.configTagLabel()
    tagLabel.textColor = .label
    tagLabel.alpha = Const.tagLabelOpacity
    tagLabel.backgroundColor = .systemGray4
  }
}
