//
//  PageScreenTopicPhotosRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 01.08.2024.
//

import UIKit

final class PageScreenTopicPhotosRootView: UIView {
  
  // MARK: - Views
  let pageScreenTopicPhotosCollectionView: PageScreenTopicPhotosCollectionView = {
    return $0
  }(PageScreenTopicPhotosCollectionView())
  
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
    addSubview(pageScreenTopicPhotosCollectionView)
  }
  
  private func setupConstraints() {
    pageScreenTopicPhotosCollectionView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor
    )
  }
}
