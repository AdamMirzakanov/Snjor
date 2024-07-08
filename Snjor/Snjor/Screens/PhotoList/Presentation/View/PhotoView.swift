//
//  PhotoView.swift
//  Snjor
//
//  Created by Адам on 08.07.2024.
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

  private var hasSetImage = false

  let mainPhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  private let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      GradientView.Color(color: .clear, location: 0.7),
      GradientView.Color(color: UIColor(white: 0, alpha: 0.5), location: 1)
    ])
    return $0
  }(GradientView())

  private let userNameLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 13, weight: .medium)
    return $0
  }(UILabel())

  // MARK: - Public Methods
  func prepareForReuse() {
    currentPhotoID = nil
    mainPhotoImageView.image = nil
    userNameLabel.text = nil
    imageDownloader.cancel()
    hasSetImage = false
  }

  func configure(with photo: Photo, showsUsername: Bool = true) {
    let size = CGSize(width: 32.0, height: 32.0)
    self.showsUsername = showsUsername
    userNameLabel.text = photo.user.displayName
    currentPhotoID = photo.id
    if let blurHash = photo.blurHash {
      if self.hasSetImage {
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
    addSubview(userNameLabel)
    setupConstraints()
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

      userNameLabel.leadingAnchor.constraint(equalTo: mainPhotoImageView.leadingAnchor, constant: 10),
      userNameLabel.bottomAnchor.constraint(equalTo: mainPhotoImageView.bottomAnchor, constant: -10)
    ])
  }

  private func downloadImage(with photo: Photo) {
    guard let url = photo.urls[.regular] else { return }
    let downloadPhotoID = photo.id
    imageDownloader.downloadPhoto(with: url) { [weak self] image, isCached in
      guard let self = self, self.currentPhotoID == downloadPhotoID
      else { return }
      if isCached == true {
        print(#function, "from the Сache")
        self.mainPhotoImageView.image = image
      } else {
        print(#function, "from the Internet")
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
