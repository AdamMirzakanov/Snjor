//
//  TopicPhotoListRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 01.08.2024.
//

import UIKit

final class TopicPhotoListRootView: UIView {
  
  // MARK: - Views
  let topicPhotoListCollectionView: TopicPhotoListCollectionView = {
    return $0
  }(TopicPhotoListCollectionView())
  
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
    addSubview(topicPhotoListCollectionView)
  }
  
  private func setupConstraints() {
    topicPhotoListCollectionView.setConstraints(
      top: safeAreaLayoutGuide.topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor
    )
  }
}
