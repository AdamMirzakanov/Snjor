//
//  UserLikedPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.09.2024.
//

import Foundation

final class UserLikedPhotoCell: MainPhotoCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUserLikedPhotoCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUserLikedPhotoCell() {
    mainView.layer.cornerRadius = 12
    mainView.clipsToBounds = true
    mainView.downloadButtonBlurEffect.isHidden = true
    mainView.userNameLabel.isHidden = true
    mainView.gradientView.isHidden = true
  }
}
