//
//  SearchResultScreenRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

class SearchResultScreenRootView: UIView {
  
  // MARK: - Collection Views
  let photosCollectionView: SearchResultPhotosCollectionView = {
    return $0
  }(SearchResultPhotosCollectionView())
  
  let albumsCollectionView: SearchResultAlbumsCollectionView = {
    return $0
  }(SearchResultAlbumsCollectionView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
    backgroundColor = .systemBackground
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
    addSubview(photosCollectionView)
    addSubview(albumsCollectionView)
  }
  
  private func setupConstraints() {
    photosCollectionView.fillSuperView()
    albumsCollectionView.fillSuperView()
  }
}

