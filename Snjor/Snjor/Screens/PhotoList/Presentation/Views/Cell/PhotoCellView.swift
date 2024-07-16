//
//  PhotoCellView.swift
//  Snjor
//
//  Created by Адам on 08.07.2024.
//

import UIKit

final class PhotoCellView: BasePhotoView {
  // MARK: - Private Properties
  private var screenScale: CGFloat { return UIScreen.main.scale }
  private var showsUsername = true {
    didSet {
      userNameLabel.alpha = showsUsername ? GlobalConst.maxAlpha : .zero
      gradientView.alpha = showsUsername ? GlobalConst.maxAlpha : .zero
    }
  }
  
  // MARK: - Private Views
  let blurEffect: UIVisualEffectView = {
    $0.frame.size.width = GlobalConst.fullValue
    $0.frame.size.height = GlobalConst.fullValue
    $0.layer.cornerRadius = GlobalConst.defaultValue
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: GlobalConst.fullValue).isActive = true
    $0.heightAnchor.constraint(equalToConstant: GlobalConst.fullValue).isActive = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  lazy var downloadButton: UIButton = {
    $0.setImage(UIImage(systemName: .downloadCellButtonImage), for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = GlobalConst.defaultAlpha
    $0.frame = blurEffect.bounds
    return $0
  }(UIButton(type: .custom))
  
  let userNameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: GlobalConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())
  
  // MARK: - Override Methods
  override func sizedImageURL(from url: URL) -> URL {
    layoutIfNeeded()
    return url.appending(queryItems: [
      URLQueryItem(name: .width, value: "\(frame.width)"),
      URLQueryItem(name: .devicePixelRatio, value: "\(Int(screenScale))")
    ])
  }
  
  override func configure(with photo: Photo, showsUsername: Bool = true) {
    super.configure(with: photo, showsUsername: showsUsername)
    self.showsUsername = showsUsername
    userNameLabel.text = photo.user.displayName
  }
  
  // MARK: - Internal Methods
  func prepareForReuse() {
    currentPhotoID = nil
    mainPhotoImageView.image = nil
    userNameLabel.text = nil
    imageDownloader.cancel()
  }
  
  func setupDownloadButton() {
    addSubview(blurEffect)
    addSubview(userNameLabel)
    blurEffect.contentView.addSubview(downloadButton)
    setupConstraints()
  }
  
  private func setupConstraints() {
    blurEffect.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      pTop: PhotoCellConst.padding,
      pRight: PhotoCellConst.padding
    )
    userNameLabel.setConstraints(
      bottom: mainPhotoImageView.bottomAnchor,
      left: mainPhotoImageView.leftAnchor,
      pBottom: PhotoCellConst.padding,
      pLeft: PhotoCellConst.padding
    )
  }
}
