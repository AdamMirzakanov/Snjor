//
//  PhotoDetailPhotoView.swift
//  Snjor
//
//  Created by Адам on 11.07.2024.
//

import UIKit

fileprivate typealias Const = PhotoDetailPhotoViewConst

final class PhotoDetailPhotoView: MainImageContainerView {
  
  // MARK: Private Properties
  private var screenScale: CGFloat {
    UIScreen.main.scale
  }
  
  // MARK: View
  let gradientView: MainGradientView = {
    let color = UIColor(
      white: .zero,
      alpha: Const.gradientOpacity
    )
    $0.setColors([
      MainGradientView.Color(
        color: .clear,
        location: Const.gradientStartLocation
      ),
      MainGradientView.Color(
        color: color,
        location: Const.gradientEndLocation
      )
    ])
    return $0
  }(MainGradientView())

  // MARK: Initializers
  override init() {
    super.init()
    setupPhotoDetailViews()
  }

  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }

  // MARK: Setup Data
  override func sizedImageURL(from url: URL) -> URL {
    layoutIfNeeded()
    let widthValue = String(describing: frame.width)
    let screenScaleValue = String(describing: Int(screenScale))
    let widthQueryItem = URLQueryItem(
      name: ParamKey.width.rawValue,
      value: widthValue
    )
    let screenScaleQueryItem = URLQueryItem(
      name: ParamKey.devicePixelRatio.rawValue,
      value: screenScaleValue
    )
    return url.appending(
      queryItems: [widthQueryItem, screenScaleQueryItem]
    )
  }
  
  func configure(
    with photo: Photo,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: photo.blurHash
    )
  }

  // MARK: Setup Views
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
