//
//  MainTagCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

import UIKit

class MainTagCell: UICollectionViewCell {
  // MARK: Views
  var tagLabel = UILabel()
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    configTagLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Cell Config
  func configure(with tag: Tag) {
    tagLabel.text = .hash + tag.title
  }
  
  func configTagLabel() {
    tagLabel.textAlignment = .center
    tagLabel.layer.cornerRadius = MainTagCellConst.tagLabelCornerRadius
    tagLabel.layer.masksToBounds = true
    tagLabel.font = .systemFont(
      ofSize: MainTagCellConst.tagFontSize,
      weight: .regular
    )
  }
  
  // MARK: Setup Views
  private func setupViews() {
    contentView.addSubview(tagLabel)
    setupTagLabelConstraints()
  }
  
  private func setupTagLabelConstraints() {
    tagLabel.fillSuperView()
  }
}
