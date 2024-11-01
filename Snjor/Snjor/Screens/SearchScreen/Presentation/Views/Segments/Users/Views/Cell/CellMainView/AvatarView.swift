//
//  AvatarView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 30.09.2024.
//

import UIKit

fileprivate typealias Const = UserTableViewCellMainViewConst

final class AvatarView: MainImageContainerView {
  // MARK: - Initializers
  override init() {
    super.init()
    configImage()
  }
  
  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
  
  // MARK: Setup Data
  func configure(with user: User, showsUsername: Bool = false, url: URL?) {
    super.configure(url: url, photoID: user.id)
  }
  
  func prepareForReuse() {
    reset()
  }
  
  private func reset() {
    currentPhotoID = nil
    mainImageView.image = nil
    imageDownloader.cancel()
  }
  
  // MARK: Setup Views
  private func configImage() {
    let cornerRadius = Const.mainImageViewCornerRadius
    mainImageView.layer.cornerRadius = cornerRadius
    mainImageView.widthAnchor.constraint(
      equalToConstant: Const.mainImageViewSize
    ).isActive = true
    mainImageView.heightAnchor.constraint(
      equalToConstant: Const.mainImageViewSize
    ).isActive = true
    mainImageView.clipsToBounds = true
  }
}
