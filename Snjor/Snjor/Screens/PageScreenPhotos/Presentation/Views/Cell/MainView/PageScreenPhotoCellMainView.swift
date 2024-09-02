//
//  PageScreenPhotoCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 30.07.2024.
//

import UIKit

final class PageScreenPhotoCellMainView: MainImageContainerView {

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
      alpha: MainPhotoViewConst.gradientAlpha
    )
    $0.setColors([
      GradientView.Color(
        color: .clear,
        location: MainPhotoViewConst.downLocation
      ),
      GradientView.Color(
        color: color,
        location: MainPhotoViewConst.upLocation
      )
    ])
    return $0
  }(GradientView())
  
  // MARK: - Profile Photo
  let profilePhotoView: PhotoDetailPhotoView = {
    $0.contentMode = .scaleAspectFill
    $0.mainImageView.image = UIImage(named: .defaultProfilePhoto)
    $0.layer.cornerRadius = GlobalConst.ultraCircle
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: GlobalConst.ultraValue
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: GlobalConst.ultraValue
    ).isActive = true
    $0.backgroundColor = .systemPurple
    return $0
  }(PhotoDetailPhotoView())
  
  // MARK: - Labels
  let userNameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: 17,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let likesLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: 15,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  // MARK: - ImageViews
  private let heartImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .heartImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  // MARK: - StackViews
  private lazy var profileStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.middleValue
    $0.addArrangedSubview(profilePhotoView)
    $0.addArrangedSubview(userNameLabel)
    return $0
  }(UIStackView())
  
  private lazy var likesStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.smallValue
    $0.addArrangedSubview(heartImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())
  
  private lazy var infoStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.middleValue
    $0.addArrangedSubview(profileStackView)
//    $0.addArrangedSubview(UIView())
//    $0.addArrangedSubview(likesStackView)
    return $0
  }(UIStackView())

  // MARK: - Initializers
  override init() {
    super.init()
    setupPhotoCellViews()
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
    with photo: Photo,
    showsUsername: Bool = true,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: photo.blurHash,
      photoID: photo.id
    )
    self.showsUsername = showsUsername
    userNameLabel.text = photo.user.displayName
    profilePhotoView.configure(
      with: photo,
      url: photo.profileImageURL
    )
    guard let likes = photo.likes else { return }
    likesLabel.text = String(describing: likes)
  }
  
  // MARK: - Setup Views
  private func setupPhotoCellViews() {
    addSubviews()
    setupConstraints()
  }

  private func addSubviews() {
    addSubview(gradientView)
    addSubview(infoStackView)
  }

  private func setupConstraints() {
    setupGradientConstraints()
    setupUserNameLabelConstraints()
  }

  private func setupGradientConstraints() {
    gradientView.fillSuperView()
  }

  private func setupUserNameLabelConstraints() {
//    infoStackView.setConstraints(
//      bottom: mainImageView.bottomAnchor,
//      left: mainImageView.leftAnchor,
//      pBottom: -50,
//      pLeft: GlobalConst.defaultValue
//    )
    
    infoStackView.setConstraints(
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pRight: GlobalConst.middleValue,
      pBottom: GlobalConst.middleValue,
      pLeft: GlobalConst.middleValue
    )
  }

  func prepareForReuse() {
    reset()
  }

  private func reset() {
    currentPhotoID = nil
    mainImageView.image = nil
    userNameLabel.text = nil
    imageDownloader.cancel()
  }
}
