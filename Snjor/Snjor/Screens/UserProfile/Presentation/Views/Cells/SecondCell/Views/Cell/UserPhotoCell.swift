//
//  UserPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import Foundation

final class UserPhotoCell: MainPhotoCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUserLikedPhotoCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUserLikedPhotoCell() {
    mainView.layer.cornerRadius = UserLikedPhotoCellConst.mainViewCornerRadius
    mainView.clipsToBounds = true
    mainView.downloadButtonBlurEffect.isHidden = true
    mainView.userNameLabel.isHidden = true
    mainView.gradientView.isHidden = true
  }
}

