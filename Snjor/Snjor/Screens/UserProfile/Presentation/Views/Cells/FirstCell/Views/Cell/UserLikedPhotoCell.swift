//
//  UserLikedPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.09.2024.
//

import Foundation

fileprivate typealias Const = UserLikedPhotoCellConst

final class UserLikedPhotoCell: MainPhotoCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUserLikedPhotoCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  private func configUserLikedPhotoCell() {
    mainView.layer.cornerRadius = Const.mainViewCornerRadius
    mainView.clipsToBounds = true
    mainView.downloadButtonBlurEffect.isHidden = true
    mainView.userNameLabel.isHidden = true
    mainView.gradientView.isHidden = true
  }
}
