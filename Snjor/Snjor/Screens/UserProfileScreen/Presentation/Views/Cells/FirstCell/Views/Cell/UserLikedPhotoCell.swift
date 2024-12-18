//
//  UserLikedPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.09.2024.
//

import Foundation

fileprivate typealias Const = UserLikedPhotoCellConst

final class UserLikedPhotoCell: MainPhotoCell {
  
  override func initViews() {
    super.initViews()
    configUserLikedPhotoCell()
  }
  
  private func configUserLikedPhotoCell() {
    rootView.mainView.layer.cornerRadius = Const.mainViewCornerRadius
    rootView.mainView.clipsToBounds = true
    rootView.mainView.downloadButtonBlurEffect.isHidden = true
    rootView.mainView.userNameLabel.isHidden = true
    rootView.mainView.gradientView.isHidden = true
  }
}
