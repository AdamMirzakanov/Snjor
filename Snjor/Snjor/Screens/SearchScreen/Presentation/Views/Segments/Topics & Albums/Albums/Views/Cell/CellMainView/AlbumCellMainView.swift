//
//  AlbumCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

final class AlbumCellMainView: MainImageContainerView {
  
  // MARK: - Private Properties
  private var screenScale: CGFloat {
    UIScreen.main.scale
  }

  let secondBackgroundView: UIView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 20.0
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  let thirdBackgroundView: UIView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 22.0
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  // MARK: - Buttons
  lazy var infoButton: UIButton = {
    let icon = UIImage(systemName: "camera.macro")
    $0.setImage(icon, for: .normal)
    $0.tintColor = .white
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = GlobalConst.defaultAlpha
    return $0
  }(UIButton(type: .custom))
  
  
  // MARK: - Gradient
  let gradientView: GradientView = {
    let color = UIColor(
      white: .zero,
      alpha: 0.7
    )
    $0.setColors([
      GradientView.Color(
        color: .clear,
        location: 0.2
      ),
      GradientView.Color(
        color: color,
        location: MainPhotoViewConst.upLocation
      )
    ])
    return $0
  }(GradientView())
  
  // MARK: - Labels
  let titleLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: 21.0,
      weight: .black
    )
    $0.numberOfLines = 6
    $0.alpha = 0.8
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = 1
    $0.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    $0.layer.shadowRadius = 0.5
    $0.layer.masksToBounds = false
    return $0
  }(UILabel())
  
  // MARK: - Initializers
  override init() {
    super.init()
    mainImageView.layer.cornerRadius = 15.0
    setupAlbumCellViews()
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
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: album.previewPhotos[.zero].blurHash,
      photoID: album.id
    )
    titleLabel.text = album.title.uppercased()
    secondBackgroundView.backgroundColor = .systemGray3
    thirdBackgroundView.backgroundColor = .systemGray5
  }
  
  func prepareForReuse() {
    reset()
  }
  
  private func reset() {
    currentPhotoID = nil
    mainImageView.image = nil
    titleLabel.text = nil
    imageDownloader.cancel()
  }
  
  // MARK: - Setup Views
  private func setupAlbumCellViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(thirdBackgroundView)
    addSubview(secondBackgroundView)
    addSubview(mainImageView)
    mainImageView.addSubview(gradientView)
    addSubview(titleLabel)
    addSubview(infoButton)
  }
  
  private func setupConstraints() {
    setupSecondBackgroundViewConstraints()
    setupThirdBackgroundViewConstraints()
    setupGradientConstraints()
    setupTitleConstraints()
    setupInfoButtonConstraints()
  }
  
  private func setupInfoButtonConstraints() {
    infoButton.setConstraints(
      right: rightAnchor,
      bottom: bottomAnchor,
      pRight: GlobalConst.defaultValue,
      pBottom: GlobalConst.defaultValue
    )
  }
  
  private func setupTitleConstraints() {
    titleLabel.setConstraints(
      top: mainImageView.topAnchor,
      right: mainImageView.rightAnchor,
      left: mainImageView.leftAnchor,
      pTop: GlobalConst.defaultValue,
      pRight: GlobalConst.defaultValue,
      pLeft: GlobalConst.defaultValue
    )
  }
  
  private func setupGradientConstraints() {
    gradientView.fillSuperView()
  }
  
  private func setupSecondBackgroundViewConstraints() {
    secondBackgroundView.setConstraints(
      top: mainImageView.topAnchor,
      right: mainImageView.rightAnchor,
      bottom: mainImageView.bottomAnchor,
      left: mainImageView.leftAnchor,
      pTop: -10,
      pRight: 3,
      pLeft: 3
    )
  }
  
  private func setupThirdBackgroundViewConstraints() {
    thirdBackgroundView.setConstraints(
      top: secondBackgroundView.topAnchor,
      right: secondBackgroundView.rightAnchor,
      bottom: secondBackgroundView.bottomAnchor,
      left: secondBackgroundView.leftAnchor,
      pTop: -10,
      pRight: 5,
      pLeft: 5
    )
  }
}
