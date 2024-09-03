//
//  PhotoDetailPhotoView.swift
//  Snjor
//
//  Created by Адам on 11.07.2024.
//

import UIKit

final class PhotoDetailPhotoView: MainImageContainerView {
  // MARK: - Gradient
  let gradientView: GradientView = {
    let color = UIColor(
      white: .zero,
      alpha: PhotoDetailPhotoViewConst.gradientOpacity
    )
    $0.setColors([
      GradientView.Color(
        color: .clear,
        location: PhotoDetailPhotoViewConst.gradientStartLocation
      ),
      GradientView.Color(
        color: color,
        location: PhotoDetailPhotoViewConst.gradientEndLocation
      )
    ])
    return $0
  }(GradientView())

  // MARK: - Initializers
  override init() {
    super.init()
    setupPhotoDetailViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup Data
  func configure(
    with photo: Photo,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: photo.blurHash
    )
  }

  // MARK: - Setup Views
  private func setupPhotoDetailViews() {
    addSubviews()
    setupConstraints()
  }

  private func addSubviews() {
    addSubview(gradientView)
  }

  private func setupConstraints() {
    gradientView.fillSuperView()
  }
}
