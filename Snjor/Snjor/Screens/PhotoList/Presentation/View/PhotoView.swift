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

  private var showsUsername = true {
    didSet {
      userNameLabel.alpha = showsUsername ? 1 : 0
      gradientView.alpha = showsUsername ? 1 : 0
    }
  }

  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.font = .systemFont(ofSize: 13, weight: .medium)
    return label
  }()

  private let waterfallPhotoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()

  private let gradientView: GradientView = {
    let gradientView = GradientView()
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    gradientView.setColors([
      GradientView.Color(color: .clear, location: 0.7),
      GradientView.Color(color: UIColor(white: 0, alpha: 0.5), location: 1)
    ])
    return gradientView
  }()

  // MARK: - Public Methods
  func prepareForReuse() {
    currentPhotoID = nil
    waterfallPhotoImageView.image = nil
    imageDownloader.cancel()
  }

  func configure(with photo: Photo, showsUsername: Bool = true) {
    self.showsUsername = showsUsername
    userNameLabel.text = photo.user.displayName
    let size = CGSize(width: 20.0, height: 20.0)
    currentPhotoID = photo.id

    if let blurHash = photo.blurHash {
      waterfallPhotoImageView.image = UIImage(blurHash: blurHash, size: size)
      // print(blurHash)
      downloadImage(with: photo)
    } else {
      // для этих мест я не стану устанавливать блюр
      // редкие случаи отсутствия блюра не бросаются в глаза
      // print(photo.blurHash, photo.user.displayName)
      downloadImage(with: photo)
    }
  }

  func setupImageView() {
    addSubview(waterfallPhotoImageView)
    addSubview(gradientView)
    addSubview(userNameLabel)
    NSLayoutConstraint.activate([
      userNameLabel.leadingAnchor.constraint(equalTo: waterfallPhotoImageView.leadingAnchor, constant: 10),
      userNameLabel.bottomAnchor.constraint(equalTo: waterfallPhotoImageView.bottomAnchor, constant: -10),

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
    guard let url = photo.urls[.regular] else {
      return
    }
    let downloadPhotoID = photo.id
    imageDownloader.downloadPhoto(with: url) { [weak self] image, isCached in
      guard let self = self,
        self.currentPhotoID == downloadPhotoID
      else { return }
      if isCached == true {
        //        print("Cache")
        self.waterfallPhotoImageView.image = image
      } else {
        //        print("Internet")
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
