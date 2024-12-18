//
//  PageScreenPhotosRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 01.08.2024.
//

import UIKit

fileprivate typealias Const = PageScreenPhotosRootViewConst

final class PageScreenPhotosRootView: BaseView {
  // MARK: Views
  let pageScreenPhotosCollectionView: PageScreenPhotosCollectionView = {
    return $0
  }(PageScreenPhotosCollectionView())
  
  // MARK: Initializers
  override func initViews() {
    setupViews()
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(pageScreenPhotosCollectionView)
  }
  
  private func setupConstraints() {
    pageScreenPhotosCollectionView.fillSuperView()
  }
}
