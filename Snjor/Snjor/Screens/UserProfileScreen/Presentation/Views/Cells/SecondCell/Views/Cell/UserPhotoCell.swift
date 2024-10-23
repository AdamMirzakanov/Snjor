//
//  UserPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import Foundation

fileprivate typealias Const = UserLikedPhotoCellConst

final class UserPhotoCell: MainPhotoCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUserPhotoCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  private func configUserPhotoCell() {
    mainView.layer.cornerRadius = Const.mainViewCornerRadius
    mainView.clipsToBounds = true
    mainView.downloadButtonBlurEffect.isHidden = true
    mainView.userNameLabel.isHidden = true
    mainView.gradientView.isHidden = true
  }
}
