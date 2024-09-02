//
//  TagCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

import UIKit

final class TagCell: UICollectionViewCell {
  
  // MARK: Views
  private let tagLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 11, weight: .regular)
    label.textColor = .label
    label.alpha = 0.6
    label.textAlignment = .center
    label.backgroundColor = .systemGray4
    label.layer.cornerRadius = 8
    label.layer.masksToBounds = true
    return label
  }()
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Cell Config
  func configure(with tag: Tag) {
    tagLabel.text = "# " + tag.title
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
