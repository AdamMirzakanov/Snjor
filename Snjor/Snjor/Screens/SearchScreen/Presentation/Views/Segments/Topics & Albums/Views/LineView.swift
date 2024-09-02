//
//  LineView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 14.08.2024.
//

import UIKit

class LineView: UICollectionReusableView, Reusable {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .lightGray
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setColor(_ color: UIColor) {
    backgroundColor = color
  }
}


class SectionHeaderView: UICollectionReusableView {
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    label.textColor = .label
    return label
  }()
  
  func setTitle(_ title: String) {
    titleLabel.text = title
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    addSubview(titleLabel)
    setupTitleLabelConstraints()
  }
  
  private func setupTitleLabelConstraints() {
    titleLabel.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pTop: 10,
      pBottom: 10
    )
  }
}

extension SectionHeaderView: Reusable {}
