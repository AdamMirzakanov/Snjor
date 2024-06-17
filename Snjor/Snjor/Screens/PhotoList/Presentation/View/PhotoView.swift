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

  private let gradientView: GradientView = {
    let gradientView = GradientView()
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    gradientView.setColors([
      GradientView.Color(color: .clear, location: 0),
      GradientView.Color(color: UIColor(white: 0, alpha: 0.3), location: 1)
    ])
    return gradientView
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
    addSubview(gradientView)
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),

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
