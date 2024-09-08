//
//  MainImageContainerView.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

import UIKit

class MainImageContainerView: UIView {
  // MARK: Internal Properties
  var currentPhotoID: String?
  let imageDownloader = ImageDownloader()
  
  let mainImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  // MARK: Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }

  // MARK: Setup Data
  /// Configure the view with a photo, url, and optional blur hash.
  /// - Parameters:
  ///   - url: The URL of the photo.
  ///   - blurHash: The optional blur hash of the photo.
  func configure(
    url: URL?,
    blurHash: String? = nil,
    photoID: String? = nil
  ) {
    currentPhotoID = photoID
    let blurSize = MainImageContainerViewConst.blurSize
    if let blurHash = blurHash {
      self.mainImageView.image = UIImage(blurHash: blurHash, size: blurSize)
      self.downloadImage(url, photoID)
    } else {
      downloadImage(url, photoID)
    }
  }

  // MARK: Setup Views
  private func setupViews() {
    addSubview(mainImageView)
    mainImageView.fillSuperView()
  }

  // MARK: Download Image
  /// Override this method to provide a custom sized image URL.
  /// - Parameter url: The original URL of the image.
  /// - Returns: The sized image URL.
  func sizedImageURL(from url: URL) -> URL {
    return url
  }

  private func downloadImage(
    _ url: URL?,
    _ photoID: String?
  ) {
    guard let url = url else { return }
    let photoURL = sizedImageURL(from: url)
    let downloadPhotoID = photoID
    imageDownloader.downloadPhoto(with: photoURL) { [weak self] (image, isCached) in
      guard let self = self,
            self.currentPhotoID == downloadPhotoID
      else { return }
      updateImage(image, isCached)
    }
  }

  private func updateImage(_ image: UIImage?, _ isCached: Bool) {
    if isCached {
      mainImageView.image = image
    } else {
      animateImageView(mainImageView, image)
    }
  }

  private func animateImageView(_ imageView: UIImageView, _ image: UIImage?) {
    UIView.transition(
      with: self,
      duration: MainImageContainerViewConst.duration,
      options: [.transitionCrossDissolve]
    ) {
      imageView.image = image
    }
  }
}
