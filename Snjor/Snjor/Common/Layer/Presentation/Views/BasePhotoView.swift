//
//  BasePhotoView.swift
//  Snjor
//
//  Created by Адам on 11.07.2024.
//

import UIKit

class BasePhotoView: UIView {
  // MARK: - Properties
  var currentPhotoID: String?
  var imageDownloader = ImageDownloader()

  // MARK: - Views
  let mainPhotoImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  let gradientView: GradientView = {
    let color = UIColor(
      white: .zero,
      alpha: BasePhotoViewConst.gradientAlpha
    )
    $0.setColors([
      GradientView.Color(
        color: .clear,
        location: BasePhotoViewConst.downLocation
      ),
      GradientView.Color(
        color: color,
        location: BasePhotoViewConst.upLocation
      )
    ])
    return $0
  }(GradientView())

  // MARK: - Internal Methods
  func configure(with photo: Photo, showsUsername: Bool) {
    let size = BasePhotoViewConst.blurSize
    currentPhotoID = photo.id
    if let blurHash = photo.blurHash {
      mainPhotoImageView.image = UIImage(blurHash: blurHash, size: size)
      downloadImage(with: photo)
    } else {
      downloadImage(with: photo)
    }
  }

  func sizedImageURL(from url: URL) -> URL {
    return url
  }

  // MARK: - Setup Views
  func setupBaseViews() {
    addSubviews()
    setupConstraints()
  }

  // MARK: - Private Methods
  private func addSubviews() {
    addSubview(mainPhotoImageView)
    addSubview(gradientView)
  }

  private func setupConstraints() {
    mainPhotoImageView.fillSuperView()
    gradientView.fillSuperView()
  }

  private func downloadImage(with photo: Photo) {
    guard let regularURL = photo.regularURL else { return }
    let url = sizedImageURL(from: regularURL)
    let downloadPhotoID = photo.id
    imageDownloader.downloadPhoto(with: url) { [weak self] image, isCached in
      guard let self = self, self.currentPhotoID == downloadPhotoID
      else { return }
      if isCached == true {
        self.mainPhotoImageView.image = image
        print(#function, "Кэш")
      } else {
        print(#function, "Интерент")
        UIView.transition(
          with: self,
          duration: BasePhotoViewConst.duration,
          options: [.transitionCrossDissolve]
        ) {
          self.mainPhotoImageView.image = image
        }
      }
    }
  }
}
