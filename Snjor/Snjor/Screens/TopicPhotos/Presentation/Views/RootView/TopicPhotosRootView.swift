//
//  TopicPhotosRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

final class TopicPhotosRootView: UIView {
  
  // MARK: - Views
  let topicPhotosCollectionView: TopicPhotosCollectionView = {
    return $0
  }(TopicPhotosCollectionView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(topicPhotosCollectionView)
  }
  
  private func setupConstraints() {
    topicPhotosCollectionView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor
    )
  }
}
