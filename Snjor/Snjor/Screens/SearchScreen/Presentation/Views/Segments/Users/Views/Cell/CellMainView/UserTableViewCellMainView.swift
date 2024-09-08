//
//  UserTableViewCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

import UIKit

final class UserTableViewCellMainView: MainImageContainerView {
  // MARK: Private Views
  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.textColor = .label
    return label
  }()
  
  lazy var stackView: UIStackView = {
    $0.spacing = 10
    $0.addArrangedSubview(mainImageView)
    $0.addArrangedSubview(userNameLabel)
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  override init() {
    super.init()
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  // MARK: Sized Image
//  override func sizedImageURL(from url: URL) -> URL {
//    layoutIfNeeded()
//    let widthValue = String(describing: frame.width)
//    let screenScaleValue = String(describing: Int(screenScale))
//    let widthQueryItem = URLQueryItem(
//      name: .width,
//      value: widthValue
//    )
//    let screenScaleQueryItem = URLQueryItem(
//      name: .devicePixelRatio,
//      value: screenScaleValue
//    )
//    return url.appending(
//      queryItems: [widthQueryItem, screenScaleQueryItem]
//    )
//  }
  
  // MARK: Setup Data
  func configure(
    with user: User,
    showsUsername: Bool = false,
    url: URL?
  ) {
    super.configure(
      url: url,
      photoID: user.id
    )
    userNameLabel.text = user.displayName
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
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(stackView)
  }
  
  private func setupConstraints() {
    stackView.fillSuperView()
  }
}
