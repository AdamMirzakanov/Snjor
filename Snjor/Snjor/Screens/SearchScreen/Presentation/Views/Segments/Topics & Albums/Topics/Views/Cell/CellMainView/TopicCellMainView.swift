//
//  TopicCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

final class TopicCellMainView: MainImageContainerView {

  // MARK: - Private Properties
  private var screenScale: CGFloat {
    UIScreen.main.scale
  }
  
  // MARK: - Labels
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
    label.textColor = .white
    label.alpha = 0.7
    label.setContentHuggingPriority(.required, for: .vertical)
    return label
  }()
  
  let visualEffectView: UIVisualEffectView = {
    let visualEffectView = UIVisualEffectView(
      effect: UIBlurEffect(style: .systemUltraThinMaterialDark)
    )
    visualEffectView.translatesAutoresizingMaskIntoConstraints = false
    return visualEffectView
  }()
  
  // MARK: - Initializers
  override init() {
    super.init()
    mainImageView.layer.cornerRadius = 15.0
    setupTopicCellViews()
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
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: visualEffectView.centerYAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),

      visualEffectView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor),
      visualEffectView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
      visualEffectView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
      visualEffectView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}
