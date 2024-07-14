//
//  PhotoCellView.swift
//  Snjor
//
//  Created by Адам on 08.07.2024.
//

import UIKit

class PhotoCellView: BasePhotoView {
  // MARK: - Private Properties
  private var showsUsername = true {
    didSet {
      userNameLabel.alpha = showsUsername ? 1 : 0
      gradientView.alpha = showsUsername ? 1 : 0
    }
  }
  
  // MARK: - Private Views
  let blurEffect: UIVisualEffectView = {
    $0.frame.size.width = 30
    $0.frame.size.height = 30
    $0.layer.cornerRadius = 6
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  lazy var downloadButton: UIButton = {
    $0.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = PhotoDetailConst.defaultAlpha
    $0.frame = blurEffect.bounds
    return $0
  }(UIButton(type: .custom))
  
  let userNameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 13, weight: .medium)
    return $0
  }(UILabel())
  
  // MARK: - Override Methods
  override func sizedImageURL(from url: URL) -> URL {
    layoutIfNeeded()
    return url.appending(queryItems: [
      URLQueryItem(name: "w", value: "\(frame.width)"),
      URLQueryItem(name: "dpr", value: "\(Int(screenScale))")
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
    hasSetImage = false
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
      pTop: 10,
      pRight: 10
    )
    userNameLabel.setConstraints(
      bottom: mainPhotoImageView.bottomAnchor,
      left: mainPhotoImageView.leftAnchor,
      pBottom: 10,
      pLeft: 10
    )
  }
}
