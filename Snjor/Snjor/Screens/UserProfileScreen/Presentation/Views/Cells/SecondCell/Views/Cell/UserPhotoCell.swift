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
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  private func configUserPhotoCell() {
    rootView.mainView.layer.cornerRadius = Const.mainViewCornerRadius
    rootView.mainView.clipsToBounds = true
    rootView.mainView.downloadButtonBlurEffect.isHidden = true
    rootView.mainView.userNameLabel.isHidden = true
    rootView.mainView.gradientView.isHidden = true
  }
}
