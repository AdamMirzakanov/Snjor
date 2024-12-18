//
//  AlbumPhotosSectionHeaderView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

fileprivate typealias Const = AlbumPhotosSectionHeaderViewConst

final class AlbumPhotosSectionHeaderView: UICollectionReusableView {
  
  let label: UILabel = {
    let label = UILabel()
    label.font = Const.titleLabelFontSize
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
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  func setImage(_ image: UIImage) {
    mainImageView.image = image
  }
}

