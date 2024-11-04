//
//  SectionHeaderView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

import UIKit

fileprivate typealias Const = SectionHeaderViewConst

final class SectionHeaderView: UICollectionReusableView {
  // MARK: Internal Properties
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(
      ofSize: Const.titleLabelFontSize,
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
    fatalError(AppLocalized.initCoderNotImplementedError)
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
      pTop: Const.defaultMargins,
      pBottom: Const.defaultMargins
    )
  }
}


final class AlbumPhotosSectionHeaderView: UICollectionReusableView, Reusable {
  
  let label: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    label.textColor = .label
    return label
  }()
  
  let mainImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  // MARK: - Применить конфигурации
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(mainImageView)
    addSubview(label)
    mainImageView.fillSuperView()
    label.fillSuperView()
  }
  
  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
  
  func setImage(_ image: UIImage) {
    mainImageView.image = image
  }
}

