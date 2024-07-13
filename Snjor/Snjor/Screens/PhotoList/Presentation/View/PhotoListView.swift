//
//  PhotoListView.swift
//  Snjor
//
//  Created by Адам on 08.07.2024.
//

import UIKit

class PhotoListView: BasePhotoView {
  // MARK: - Private Properties
  private var showsUsername = true {
    didSet {
      userNameLabel.alpha = showsUsername ? 1 : 0
      gradientView.alpha = showsUsername ? 1 : 0
    }
  }
  
  // MARK: - Private Views
  let downloadBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = 30
    $0.frame.size.height = 30
    $0.layer.cornerRadius = 6
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  lazy var downloadBarButton: UIButton = {
    $0.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alphaDefault
    $0.frame = downloadBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))
  
  let userNameLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
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
    addSubview(downloadBarButtonBlurView)
    addSubview(userNameLabel)
    downloadBarButtonBlurView.contentView.addSubview(downloadBarButton)
    setupDownloadButtonConstraints()
  }
  
  private func setupDownloadButtonConstraints() {
    downloadBarButtonBlurView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      downloadBarButtonBlurView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      downloadBarButtonBlurView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      downloadBarButtonBlurView.widthAnchor.constraint(equalToConstant: 30),
      downloadBarButtonBlurView.heightAnchor.constraint(equalToConstant: 30),
      
      userNameLabel.leadingAnchor.constraint(equalTo: mainPhotoImageView.leadingAnchor, constant: 10),
      userNameLabel.bottomAnchor.constraint(equalTo: mainPhotoImageView.bottomAnchor, constant: -10)
    ])
  }
}
