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
    $0.layer.cornerRadius = AlbumCellMainViewConst.secondBackgroundViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  let thirdBackgroundView: UIView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = AlbumCellMainViewConst.thirdBackgroundViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  // MARK: - Buttons
  lazy var infoButton: UIButton = {
    let icon = UIImage(systemName: .cameraMacro)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .white
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = AlbumCellMainViewConst.infoButtonOpacity
    return $0
  }(UIButton(type: .custom))
  
  
  // MARK: - Gradient
  let gradientView: GradientView = {
    let color = UIColor(
      white: .zero,
      alpha: AlbumCellMainViewConst.gradientOpacity
    )
    $0.setColors([
      GradientView.Color(
        color: .clear,
        location: AlbumCellMainViewConst.gradientStartLocation
      ),
      GradientView.Color(
        color: color,
        location: AlbumCellMainViewConst.gradientEndLocation
      )
    ])
    return $0
  }(GradientView())
  
  // MARK: - Labels
  let titleLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: AlbumCellMainViewConst.titleLabelFontSize,
      weight: .black
    )
    $0.numberOfLines = AlbumCellMainViewConst.titleLabelNumberOfLines
    $0.alpha = AlbumCellMainViewConst.titleLabelOpacity
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = AlbumCellMainViewConst.titleLabelShadowOpacity
    $0.layer.shadowOffset = CGSize(
      width: AlbumCellMainViewConst.shadowOffset,
      height: AlbumCellMainViewConst.shadowOffset
    )
    $0.layer.shadowRadius = AlbumCellMainViewConst.shadowRadius
    $0.layer.masksToBounds = false
    return $0
  }(UILabel())
  
  // MARK: - Initializers
  override init() {
    super.init()
    setupViews()
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
  private func setupViews() {
    addSubviews()
    setupConstraints()
    mainImageView.layer.cornerRadius = AlbumCellMainViewConst.mainImageViewCornerRadius
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
      pRight: AlbumCellMainViewConst.defaultValue,
      pBottom: AlbumCellMainViewConst.defaultValue
    )
  }
  
  private func setupTitleConstraints() {
    titleLabel.setConstraints(
      top: mainImageView.topAnchor,
      right: mainImageView.rightAnchor,
      left: mainImageView.leftAnchor,
      pTop: AlbumCellMainViewConst.defaultValue,
      pRight: AlbumCellMainViewConst.defaultValue,
      pLeft: AlbumCellMainViewConst.defaultValue
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
      pTop: AlbumCellMainViewConst.topAnchor,
      pRight: AlbumCellMainViewConst.secondBackgroundViewMargins,
      pLeft: AlbumCellMainViewConst.secondBackgroundViewMargins
    )
  }
  
  private func setupThirdBackgroundViewConstraints() {
    thirdBackgroundView.setConstraints(
      top: secondBackgroundView.topAnchor,
      right: secondBackgroundView.rightAnchor,
      bottom: secondBackgroundView.bottomAnchor,
      left: secondBackgroundView.leftAnchor,
      pTop: AlbumCellMainViewConst.topAnchor,
      pRight: AlbumCellMainViewConst.thirdBackgroundViewMargins,
      pLeft: AlbumCellMainViewConst.thirdBackgroundViewMargins
    )
  }
}
