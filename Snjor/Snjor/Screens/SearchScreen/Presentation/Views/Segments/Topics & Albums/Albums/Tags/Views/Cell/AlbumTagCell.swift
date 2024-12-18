//
//  AlbumTagCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

fileprivate typealias Const = MainTagCellConst

final class AlbumTagCell: MainTagCell {
  override func initCell() {
    super.initCell()
    rootView.tagLabel.textColor = .label
    rootView.tagLabel.alpha = Const.tagLabelOpacity
    rootView.tagLabel.backgroundColor = .systemGray4
  }
}
