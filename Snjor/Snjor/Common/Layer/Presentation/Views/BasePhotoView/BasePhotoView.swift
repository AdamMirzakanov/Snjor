//
//  BasePhotoView.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

import UIKit

class BasePhotoView: UIView {
  // MARK: - Properties
  var imageDownloader = ImageDownloader()

  // MARK: - Main Photo
  let mainImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup Data
  func configure<T: Decodable>(
    with photo: T,
    url: URL?,
    blurHash: String?
  ) {
    let size = BasePhotoViewConst.blurSize
    if let blurHash = blurHash {
      mainImageView.image = UIImage(blurHash: blurHash, size: size)
      downloadImage(with: photo, url: url)
    } else {
      downloadImage(with: photo, url: url)
    }
  }

  // MARK: - Setup Views
  private func setupViews() {
    addSubview(mainImageView)
    mainImageView.fillSuperView()
  }

  // MARK: - Download Image
  func sizedImageURL(from url: URL) -> URL {
    return url
  }

  private func downloadImage<T: Decodable>(with photo: T, url: URL?) {
    guard let url = url else { return }
    let photoUrl = sizedImageURL(from: url)
    imageDownloader.downloadPhoto(with: photoUrl) { [weak self] image, isCached in
      guard let self = self
      else {
        return
      }
      if isCached == true {
        self.mainImageView.image = image
        print(#function, "Кэш")
      } else {
        print(#function, "Интерент")
        UIView.transition(
          with: self,
          duration: BasePhotoViewConst.duration,
          options: [.transitionCrossDissolve]
        ) {
          self.mainImageView.image = image
        }
      }
    }
  }
}
