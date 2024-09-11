//
//  UserProfilePhotoView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

import Foundation

final class UserProfilePhotoView: MainImageContainerView {
  
  func configure(
    with photo: Photo,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: photo.blurHash
    )
  }
  
  func configure(
    with user: User,
    url: URL?
  ) {
    super.configure(
      url: url
    )
  }
}
