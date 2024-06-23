//
//  PhotoViewRegularQuality.swift
//  Snjor
//
//  Created by Адам on 23.06.2024.
//

import UIKit

class PhotoViewRegularQuality: UIView {
  // MARK: - Private Properties
  private var currentPhotoID: String?
  private var imageDownloader = ImageDownloader()

  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  // MARK: - Public Methods
  func configure(with photo: Photo, showsUsername: Bool = true) {
    let size = CGSize(width: 32.0, height: 32.0)
    currentPhotoID = photo.id
    if let blurHash = photo.blurHash {
      photoImageView.image = UIImage(blurHash: blurHash, size: size)
      downloadImage(with: photo)
    } else {
      downloadImage(with: photo)
    }
  }

  func setupImageView() {
    addSubview(photoImageView)
    NSLayoutConstraint.activate([
      photoImageView.topAnchor.constraint(equalTo: topAnchor),
      photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  // MARK: - Private Methods
  private func downloadImage(with photo: Photo) {
    guard let url = photo.urls[.regular] else { return }
    let downloadPhotoID = photo.id
    imageDownloader.downloadPhoto(with: url) { [weak self] image, isCached in
      guard let self = self,
        self.currentPhotoID == downloadPhotoID
      else { return }
      if isCached == true {
        self.photoImageView.image = image
      } else {
        UIView.transition(
          with: self,
          duration: 0.25,
          options: [.transitionCrossDissolve]) {
            self.photoImageView.image = image
        }
      }
    }
  }
}
