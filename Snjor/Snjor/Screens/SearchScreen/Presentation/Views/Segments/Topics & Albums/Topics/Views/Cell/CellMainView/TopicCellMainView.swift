//
//  TopicCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

fileprivate typealias Const = TopicCellMainViewConst

final class TopicCellMainView: MainImageContainerView {
  // MARK: Private Properties
  private var screenScale: CGFloat {
    UIScreen.main.scale
  }
  
  // MARK: Labels
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(
      ofSize: Const.titleLabelFontSize,
      weight: .regular
    )
    label.textColor = .white
    label.alpha = Const.titleLabelOpacity
    label.setContentHuggingPriority(.required, for: .vertical)
    return label
  }()
  
  let visualEffectView: UIVisualEffectView = {
    let visualEffectView = UIVisualEffectView(
      effect: UIBlurEffect(style: .systemUltraThinMaterialDark)
    )
    visualEffectView.translatesAutoresizingMaskIntoConstraints = false
    visualEffectView.heightAnchor.constraint(
      equalToConstant: Const.visualEffectViewHeight
    ).isActive = true
    return visualEffectView
  }()
  
  // MARK: Initializers
  override init() {
    super.init()
    mainImageView.layer.cornerRadius = Const.cellCornerRadius
    setupTopicCellViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
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
    with topic: Topic,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: topic.coverPhoto.blurHash,
      photoID: topic.id
    )
    titleLabel.text = topic.title
  }
  
  func prepareForReuse() {
    reset()
  }
  
  private func reset() {
    currentPhotoID = nil
    mainImageView.image = nil
    imageDownloader.cancel()
  }
  
  // MARK: - Setup Views
  private func setupTopicCellViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(titleLabel)
    mainImageView.addSubview(visualEffectView)
  }
  
  private func setupConstraints() {
    setupTitleLabelConstraints()
    setupVisualEffectViewConstraints()
  }
  
  private func setupTitleLabelConstraints() {
    titleLabel.setConstraints(
      centerY: visualEffectView.centerYAnchor,
      centerX: visualEffectView.centerXAnchor
    )
  }
  
  private func setupVisualEffectViewConstraints() {
    visualEffectView.setConstraints(
      right: mainImageView.rightAnchor,
      bottom: mainImageView.bottomAnchor,
      left: mainImageView.leftAnchor
    )
  }
}
