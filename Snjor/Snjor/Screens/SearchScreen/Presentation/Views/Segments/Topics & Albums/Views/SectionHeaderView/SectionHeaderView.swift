//
//  SectionHeaderView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {
  
  // MARK: Internal Properties
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(
      ofSize: SectionHeaderViewConst.titleLabelFontSize,
      weight: .bold
    )
    label.textColor = .label
    return label
  }()
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Internal Methods
  func setTitle(_ title: String) {
    titleLabel.text = title
  }
  
  // MARK: Private Methods
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
      pTop: SectionHeaderViewConst.defaultMargins,
      pBottom: SectionHeaderViewConst.defaultMargins
    )
  }
}
