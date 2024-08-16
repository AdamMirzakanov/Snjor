//
//  AlbumCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

final class AlbumCellMainView: BaseImageContainerView {
  
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

  let secondImageView: UIView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 20.0
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  let thirdImageView: UIView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 22.0
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  // MARK: - Gradient
  let gradientView: GradientView = {
    let color = UIColor(
      white: .zero,
      alpha: 0.7
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
      ofSize: 25.0,
      weight: .black
    )
    $0.numberOfLines = 0
    $0.alpha = 0.8
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = 1
    $0.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    $0.layer.shadowRadius = 0.5
    $0.layer.masksToBounds = false
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
      ofSize: 12.0,
      weight: .medium
    )
    $0.alpha = 0.8
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
    showsUsername: Bool = true,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: album.previewPhotos[.zero].blurHash,
      photoID: album.id
    )
    self.showsUsername = showsUsername
    titleLabel.text = album.title.uppercased()
    totalPhotosLabel.text = "\(album.totalPhotos) photos"
    
    secondImageView.backgroundColor = .systemGray3
    thirdImageView.backgroundColor = .systemGray5
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
    addSubview(thirdImageView)
    addSubview(secondImageView)
    addSubview(mainImageView)
    mainImageView.addSubview(gradientView)
    addSubview(titleLabel)
    addSubview(totalPhotosLabel)
  }
  
  private func setupConstraints() {
    mainImageView.translatesAutoresizingMaskIntoConstraints = false
    secondImageView.translatesAutoresizingMaskIntoConstraints = false
    thirdImageView.translatesAutoresizingMaskIntoConstraints = false
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      // mainImageView constraints
      mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      mainImageView.topAnchor.constraint(equalTo: topAnchor),
      mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      // secondImageView constraints
      secondImageView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 3),
      secondImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -3),
      secondImageView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: -8),
      secondImageView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 0),
      
      // thirdImageView constraints
      thirdImageView.leadingAnchor.constraint(equalTo: secondImageView.leadingAnchor, constant: 5),
      thirdImageView.trailingAnchor.constraint(equalTo: secondImageView.trailingAnchor, constant: -5),
      thirdImageView.topAnchor.constraint(equalTo: secondImageView.topAnchor, constant: -8),
      thirdImageView.bottomAnchor.constraint(equalTo: secondImageView.bottomAnchor, constant: 0),
      
      // gradientView constraints
      gradientView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
      gradientView.topAnchor.constraint(equalTo: mainImageView.topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor)
    ])
    
    totalPhotosLabel.setConstraints(
      right: mainImageView.rightAnchor,
      bottom: mainImageView.bottomAnchor,
      pRight: GlobalConst.defaultValue,
      pBottom: GlobalConst.defaultValue
    )
    
    titleLabel.setConstraints(
      top: mainImageView.topAnchor,
      right: mainImageView.rightAnchor,
      left: mainImageView.leftAnchor,
      pTop: GlobalConst.defaultValue,
      pRight: GlobalConst.defaultValue,
      pLeft: GlobalConst.defaultValue
    )
  }
}


