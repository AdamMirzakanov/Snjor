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
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  let gradientView: GradientView = {
    let color = UIColor(white: .zero, alpha: BasePhotoViewConst.gradientAlpha)
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

  func setupBaseViews() {
    addSubviews()
    setupConstraints()
  }

  func sizedImageURL(from url: URL) -> URL {
    return url
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
        print(#function, "🟡 Сache")
        self.mainPhotoImageView.image = image
      } else {
        print(#function, "🟢 Internet")
        UIView.transition(
          with: self,
          duration: BasePhotoViewConst.duration,
          options: [.transitionCrossDissolve]) {
            self.mainPhotoImageView.image = image
          }
      }
    }
  }
}
