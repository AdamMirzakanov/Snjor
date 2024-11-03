//
//  AvatarPhotoView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 03.11.2024.
//

import Foundation

final class AvatarPhotoView: MainImageContainerView {
  
  /// Базовая реализация данного метода на экране профиля вызывает неправильное
  /// заполнение фотографии профиля, по этой причине он здесь перезаписан.
  override func sizedImageURL(from url: URL) -> URL {
    return url
  }
  
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
