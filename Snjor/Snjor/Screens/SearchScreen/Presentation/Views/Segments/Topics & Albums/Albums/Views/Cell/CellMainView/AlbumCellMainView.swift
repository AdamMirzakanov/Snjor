//
//  AlbumCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

fileprivate typealias Const = AlbumCellMainViewConst

final class AlbumCellMainView: MainImageContainerView {
  // MARK: Private Properties
  private var screenScale: CGFloat {
    UIScreen.main.scale
  }

  private let secondBackgroundView: UIView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = Const.secondBackgroundViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  private let thirdBackgroundView: UIView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = Const.thirdBackgroundViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  // MARK: Buttons
  private lazy var macroIconButton: UIButton = {
    let icon = SFSymbol.cameraMacroIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .white
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = Const.infoButtonOpacity
    return $0
  }(UIButton(type: .system))
  
  // MARK: Gradient
  private let gradientView: MainGradientView = {
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
  
  // MARK: Labels
  private let titleLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.titleLabelFontSize,
      weight: .black
    )
    $0.numberOfLines = Const.titleLabelNumberOfLines
    $0.alpha = Const.titleLabelOpacity
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = Const.titleLabelShadowOpacity
    $0.layer.shadowOffset = CGSize(
      width: Const.shadowOffset,
      height: Const.shadowOffset
    )
    $0.layer.shadowRadius = Const.shadowRadius
    $0.layer.masksToBounds = false
    return $0
  }(UILabel())
  
  // MARK: Initializers
  override init() {
    super.init()
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Sized Image
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
  
  // MARK: Setup Data
  func configure(
    with album: Album,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: album.previewPhotos?[.zero].blurHash,
      photoID: album.id
    )
    if album.previewPhotos == nil {
      mainImageView.image = SFSymbol.photoCap
    }
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
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
    mainImageView.layer.cornerRadius = Const.mainImageViewCornerRadius
  }
  
  private func addSubviews() {
    addSubview(thirdBackgroundView)
    addSubview(secondBackgroundView)
    addSubview(mainImageView)
    mainImageView.addSubview(gradientView)
    addSubview(titleLabel)
    addSubview(macroIconButton)
  }
  
  private func setupConstraints() {
    setupSecondBackgroundViewConstraints()
    setupThirdBackgroundViewConstraints()
    setupGradientConstraints()
    setupTitleConstraints()
    setupInfoButtonConstraints()
  }
  
  private func setupInfoButtonConstraints() {
    macroIconButton.setConstraints(
      right: rightAnchor,
      bottom: bottomAnchor,
      pRight: Const.defaultValue,
      pBottom: Const.defaultValue
    )
  }
  
  private func setupTitleConstraints() {
    titleLabel.setConstraints(
      top: mainImageView.topAnchor,
      right: mainImageView.rightAnchor,
      left: mainImageView.leftAnchor,
      pTop: Const.defaultValue,
      pRight: Const.defaultValue,
      pLeft: Const.defaultValue
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
      pTop: Const.topAnchor,
      pRight: Const.secondBackgroundViewMargins,
      pLeft: Const.secondBackgroundViewMargins
    )
  }
  
  private func setupThirdBackgroundViewConstraints() {
    thirdBackgroundView.setConstraints(
      top: secondBackgroundView.topAnchor,
      right: secondBackgroundView.rightAnchor,
      bottom: secondBackgroundView.bottomAnchor,
      left: secondBackgroundView.leftAnchor,
      pTop: Const.topAnchor,
      pRight: Const.thirdBackgroundViewMargins,
      pLeft: Const.thirdBackgroundViewMargins
    )
  }
}
