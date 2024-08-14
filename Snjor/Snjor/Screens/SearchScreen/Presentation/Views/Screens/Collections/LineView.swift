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

    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
