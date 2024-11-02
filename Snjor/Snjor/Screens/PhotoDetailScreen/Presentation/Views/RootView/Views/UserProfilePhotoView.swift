//
//  UserProfilePhotoView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

import UIKit

final class UserProfilePhotoView: MainImageContainerView {
  
  private var screenScale: CGFloat {
    UIScreen.main.scale
  }
  
  override func sizedImageURL(from url: URL) -> URL {
    layoutIfNeeded()
    let widthValue = String(describing: frame.width)
    let screenScaleValue = String(describing: Int(screenScale))
    let widthQueryItem = URLQueryItem(
      name: ParamKey.width.rawValue,
      value: widthValue
    )
    let screenScaleQueryItem = URLQueryItem(
      name: ParamKey.devicePixelRatio.rawValue,
      value: screenScaleValue
    )
    return url.appending(
      queryItems: [widthQueryItem, screenScaleQueryItem]
    )
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
