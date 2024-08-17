//
//  TopicPhotoCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

final class TopicPhotoCellMainView: BaseImageContainerView {
  
  // MARK: - Private Properties
  private var screenScale: CGFloat {
    UIScreen.main.scale
  }

  // MARK: - Initializers
  override init() {
    super.init()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Sized Image
  override func sizedImageURL(from url: URL) -> URL {
    layoutIfNeeded()
    let widthValue = String(describing: frame.width)
    let screenScaleValue = String(describing: Int(screenScale))
    let widthQueryItem = URLQueryItem(
      name: .width,
      value: widthValue
    )
    let screenScaleQueryItem = URLQueryItem(
      name: .devicePixelRatio,
      value: screenScaleValue
    )
    return url.appending(
      queryItems: [widthQueryItem, screenScaleQueryItem]
    )
  }

  // MARK: - Setup Data
  func configure(
    with photo: Photo,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: photo.blurHash,
      photoID: photo.id
    )
  }
  
  // MARK: - Setup Views
  func prepareForReuse() {
    reset()
  }
  
  private func reset() {
    currentPhotoID = nil
    imageDownloader.cancel()
  }
}
