//
//  AlbumListCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

final class AlbumListCellMainView: BaseImageContainerView {
  
  // MARK: - Private Properties
  private var screenScale: CGFloat {
    UIScreen.main.scale
  }
  
  private var showsUsername = true {
    didSet {
      userNameLabel.alpha = showsUsername ? GlobalConst.maxAlpha : .zero
      gradientView.alpha = showsUsername ? GlobalConst.maxAlpha : .zero
    }
  }
  
  // MARK: - Gradient
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
  
  // MARK: - Labels
  let titleLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let userNameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let totalPhotosLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  // MARK: - Initializers
  override init() {
    super.init()

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Sized Image
  override func sizedImageURL(from url: URL) -> URL {
    layoutIfNeeded()
    let widthValue = String(describing: frame.width)
    let screenScaleValue = String(describing: Int(screenScale))
    let widthQueryItem = URLQueryItem(
      name: .width,
      value: widthValue
    )
    let screenScaleQueryItem = URLQueryItem(
      name: .devicePixelRatio,
      value: screenScaleValue
    )
    return url.appending(
      queryItems: [widthQueryItem, screenScaleQueryItem]
    )
  }
  
  // MARK: - Setup Data
  func configure(
    with album: Album,
    showsUsername: Bool = true,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: album.previewPhotos[0].blurHash,
      photoID: album.id
    )
    self.showsUsername = showsUsername
//    userNameLabel.text = album.user.displayName
  }
  
  func prepareForReuse() {
    reset()
  }
  
  private func reset() {
    currentPhotoID = nil
    mainImageView.image = nil
    userNameLabel.text = nil
    titleLabel.text = nil
    totalPhotosLabel.text = nil
    imageDownloader.cancel()
  }
  
  // MARK: - Setup Views
  private func setupAlbumCellViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(gradientView)
//    addSubview(titleLabel)
//    addSubview(userNameLabel)
//    addSubview(totalPhotosLabel)
    
  }

  private func setupConstraints() {
    setupGradientConstraints()
  }
  
  private func setupGradientConstraints() {
    gradientView.fillSuperView()
  }
}
