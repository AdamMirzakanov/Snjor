//
//  PhotoView.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

class PhotoView: UIView {
  // MARK: - Private Properties
  private var currentPhotoID: String?
  private var imageDownloader = ImageDownloader()
  private var screenScale: CGFloat { return UIScreen.main.scale }

  private let waterfallPhotoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  // MARK: - Public Methods
  func prepareForReuse() {
    currentPhotoID = nil
    waterfallPhotoImageView.image = nil
    imageDownloader.cancel()
  }

  func configure(with photo: Photo) {
    let size = CGSize(width: 32.0, height: 32.0)
    currentPhotoID = photo.id
    waterfallPhotoImageView.image = UIImage(blurHash: photo.blurHash, size: size)
    downloadImage(with: photo)
  }

  func setupImageView() {
    addSubview(waterfallPhotoImageView)
    NSLayoutConstraint.activate([
      waterfallPhotoImageView.topAnchor.constraint(equalTo: topAnchor),
      waterfallPhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      waterfallPhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      waterfallPhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  // MARK: - Private Methods
  private func downloadImage(with photo: Photo) {
    guard let url = photo.urls[.small] else {
      return
    }
    let downloadPhotoID = photo.id
    imageDownloader.downloadPhoto(with: url) { [weak self] image, isCached in
      guard let self = self,
        self.currentPhotoID == downloadPhotoID
      else { return }
      if isCached == true {
        print("Cache")
        self.waterfallPhotoImageView.image = image
      } else {
        print("Internet")
        UIView.transition(
          with: self,
          duration: 0.25,
          options: [.transitionCrossDissolve]) {
            self.waterfallPhotoImageView.image = image
        }
      }
    }
  }
}
