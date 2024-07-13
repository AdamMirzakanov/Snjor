//
//  BasePhotoView.swift
//  Snjor
//
//  Created by Адам on 11.07.2024.
//

import UIKit

class BasePhotoView: UIView {
  // MARK: - Internal Properties
  var screenScale: CGFloat { return UIScreen.main.scale }
  var currentPhotoID: String?
  var imageDownloader = ImageDownloader()
  var hasSetImage = false

  // MARK: - Internal Views
  let mainPhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      GradientView.Color(color: .clear, location: 0.7),
      GradientView.Color(color: UIColor(white: 0, alpha: 0.5), location: 1)
    ])
    return $0
  }(GradientView())

  // MARK: - Internal Methods
  func configure(with photo: Photo, showsUsername: Bool) {
    let size = CGSize(width: 32.0, height: 32.0)
    currentPhotoID = photo.id
    if let blurHash = photo.blurHash {
      if self.hasSetImage == true {
        return
      }
      mainPhotoImageView.image = UIImage(blurHash: blurHash, size: size)
      downloadImage(with: photo)
      self.hasSetImage = true
    } else {
      downloadImage(with: photo)
    }
  }

  func setupImageView() {
    addSubview(mainPhotoImageView)
    addSubview(gradientView)
    setupConstraints()
  }

  func sizedImageURL(from url: URL) -> URL {
    return url
  }

  // MARK: - Private Methods
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      mainPhotoImageView.topAnchor.constraint(equalTo: topAnchor),
      mainPhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      mainPhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainPhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }

  private func downloadImage(with photo: Photo) {
    guard let regularURL = photo.regularURL else { return }
    let url = sizedImageURL(from: regularURL)
    let downloadPhotoID = photo.id
    imageDownloader.downloadPhoto(with: url) { [weak self] image, isCached in
      guard let self = self, self.currentPhotoID == downloadPhotoID
      else { return }
      if isCached == true {
//        print(#function, "from the Сache")
        self.mainPhotoImageView.image = image
      } else {
//        print(#function, "from the Internet")
        UIView.transition(
          with: self,
          duration: 0.25,
          options: [.transitionCrossDissolve]) {
            self.mainPhotoImageView.image = image
          }
      }
    }
  }
}
